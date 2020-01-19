const { db, admin } = require("../util/admin");

const {
  reduceMedicineDetails,
  validateAddMedicinePayload,
  validateDeleteMedicinePayload,
  isEmpty
} = require("../util/validators");

const { removePatientMedicine } = require("../modules/patients");

const { getItems } = require("../modules/generic");

exports.getMedicineById = async (req, res) => {
  let medicinesDetails = {};
  try {
    console.log(req.params);
    const data = await db.doc(`/medicines/${req.params.medicineId}`).get();

    // console.log(data.data());
    if (data.exists) {
      medicinesDetails = data.data();
      medicinesDetails.medicineId = data.id;
      return res.status(200).json(medicinesDetails);
    } else {
      return res.status(404).json({ errror: "medicine not found" });
    }
  } catch (e) {
    return res.status(500).json(e.code);
  }
};

exports.addMedicine = async (req, res) => {
  try {
    if (isEmpty(req.params.patientId))
      return res
        .status(400)
        .json({ error: "Parameter patientId is required." });

    // add medicine into medicines collection
    let newMedicine = reduceMedicineDetails(req.body);
    newMedicine.createdAt = new Date().toISOString();

    const { errors, valid } = validateAddMedicinePayload(newMedicine);

    if (!valid) return res.status(400).json(errors);

    let result = {};
    let document = await db.collection("medicines").add(newMedicine);

    result.id = document.id;

    // add medicine to patient's medicines collection
    let patient = db.collection("patients").doc(req.params.patientId);

    await patient.update({
      medicines: admin.firestore.FieldValue.arrayUnion(document.id)
    });

    return res.status(201).json(result.id);
  } catch (e) {
    return res.status(500).json(e.code);
  }
};

exports.updateMedicine = async (req, res) => {
  try {
    if (isEmpty(req.params.medicineId))
      return res
        .status(400)
        .json({ error: "Parameter medicineId is required." });

    let newMedicine = reduceMedicineDetails(req.body);
    newMedicine.createdAt = new Date().toISOString();

    const { errors, valid } = validateAddMedicinePayload(newMedicine);

    if (!valid) return res.status(400).json(errors);

    let result = await db
      .collection("medicines")
      .doc(req.params.medicineId)
      .set(req.body, { merge: true });

    return res.status(200).json(result);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e.code);
  }
};

exports.deleteMedicine = async (req, res) => {
  try {
    const { verrors, vvalid } = validateDeleteMedicinePayload(req.body);
    if (!vvalid) return res.status(400).json(verrors);

    const { errors, valid } = removePatientMedicine(
      req.body.patientId,
      req.body.medicineId
    );

    if (!valid) return res.status(400).json(errors);

    return res.status(201).json("Ok");
  } catch (e) {
    console.error(e);
    return res.status(500).json(e.code);
  }
};

exports.getMedicinesByPatient = async (req, res) => {
  try {
    if (isEmpty(req.params.patientId))
      return res
        .status(400)
        .json({ error: "Parameter patientId is required." });

    let doc = await db
      .collection("patient")
      .doc(req.params.patientId)
      .get();

    let medicineIds = doc.data().medicines;

    const { errors, results, valid } = await getItems("medicines", medicineIds);

    if (!valid) return res.status(400).json(errors);

    return res.status(200).json(results);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e.code);
  }
};
