const { db, admin } = require("../util/admin");

const {
  isEmpty,
  reduceScheduleDetails,
  validateAddSchedulePayload
} = require("../util/validators");

const { removePatientSchedule } = require("../modules/patients");
const { getSchedules } = require("../modules/schedules");

exports.getScheduleById = async (req, res) => {
  if (isEmpty(req.params.scheduleId)) {
    return res.status(400).json({ error: "sheduleId is required" });
  }

  let scheduleDetails = {};

  try {
    console.log(req.params);
    const data = await db.doc(`/schedules/${req.params.scheduleId}`).get();

    if (data.exists) {
      scheduleDetails = data.data();
      scheduleDetails.scheduleId = data.id;
      return res.status(200).json(scheduleDetails);
    } else {
      return res.status(404).json({ errror: "schedule not found" });
    }
  } catch (e) {
    return res.status(500).json(e.code);
  }
};

exports.addSchedule = async (req, res) => {
  try {
    if (isEmpty(req.params.patientId))
      return res
        .status(400)
        .json({ error: "Parameter patientId is required." });

    // add schedule into patient's schedules collection
    let newSchedule = reduceScheduleDetails(req.body);
    newSchedule.createdAt = new Date().toISOString();

    const { errors, valid } = validateAddSchedulePayload(newSchedule);

    if (!valid) return res.status(400).json(errors);

    let result = {};
    let document = await db.collection("schedules").add(newSchedule);

    result.id = document.id;

    // add medicine to patient's schedules collection
    let patient = db.collection("patients").doc(req.params.patientId);

    await patient.update({
      schedules: admin.firestore.FieldValue.arrayUnion(document.id)
    });

    return res.status(201).json(result.id);
  } catch (e) {
    return res.status(500).json(e.code);
  }
};

exports.updateSchedule = async (req, res) => {
  try {
    if (isEmpty(req.params.scheduleId))
      return res
        .status(400)
        .json({ error: "Parameter scheduleId is required." });

    let newMedicine = reduceScheduleDetails(req.body);
    newMedicine.createdAt = new Date().toISOString();

    const { errors, valid } = validateAddSchedulePayload(newMedicine);

    if (!valid) return res.status(400).json(errors);

    let result = await db
      .collection("schedules")
      .doc(req.params.scheduleId)
      .set(req.body, { merge: true });

    return res.status(200).json(result);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e.code);
  }
};

exports.deleteSchedule = async (req, res) => {
  try {
    const { verrors, vvalid } = validateDeleteSchedulePayload(req.body);
    if (!vvalid) return res.status(400).json(verrors);

    const { errors, valid } = removePatientSchedule(
      req.body.patientId,
      req.body.scheduleId
    );

    if (!valid) return res.status(400).json(errors);

    return res.status(201).json("Ok");
  } catch (e) {
    console.error(e);
    return res.status(500).json(e.code);
  }
};

exports.getSchedulesByPatient = async (req, res) => {
  try {
    if (isEmpty(req.params.patientId))
      return res
        .status(400)
        .json({ error: "Parameter patientId is required." });

    let doc = await db
      .collection("patient")
      .doc(req.params.patientId)
      .get();

    let scheduleIds = doc.data().schedules;

    console.log(scheduleIds);

    const { errors, results, valid } = await getSchedules(scheduleIds);

    if (!valid) return res.status(400).json(errors);

    return res.status(200).json(results);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e.code);
  }
};
