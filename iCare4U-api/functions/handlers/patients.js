const { db } = require("../util/admin");

const { reducePatientDetails } = require("../util/validators");

exports.getAllPatients = async (req, res) => {
  try {
    const data = await db.collection("patient").get();

    let items = [];
    data.docs.forEach(doc => {
      items.push(doc.data());
    });

    return res.status(200).json(items);
  } catch (e) {
    return res.status(500).json(e);
  }
};

exports.getPatientDetails = async (req, res) => {
  let patientDetails = {};
  try {
    console.log(req.params);
    const data = await db.doc(`/patient/${req.params.patientId}`).get();

    //console.log(data.data());
    if (data) {
      patientDetails = data.data();
      patientDetails.patientId = data.id;
      return res.status(200).json(patientDetails);
    } else {
      return res.status(404).json({ errror: "Patient not found" });
    }
  } catch (e) {
    return res.status(500).json(e);
  }
};

exports.addPatientDetails = async (req, res) => {
  try {
    console.log(req.body);
    if (req.body.patientName.trim() === "") {
      return res.status(400).json({ body: "Body must not be empty" });
    }

    let newPatient = reducePatientDetails(req.body);
    newPatient.createdAt = new Date().toISOString();

    let doc = await db.collection("patient").add(newPatient);
    const resPatient = newPatient;
    resPatient.patientId = doc.id;

    return res.json(resPatient);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ error: "something went wrong" });
  }
};
