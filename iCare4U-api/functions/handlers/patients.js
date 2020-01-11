const { db } = require("../util/admin");

const { reducePatientDetails } = require("../util/validators");

const patientsModule = require("../modules/patients");
const groupModule = require("../modules/userGroups");

exports.getPatientsByUser = async (req, res) => {
  try {
    console.log(req.params);

    let patientIds = [];

    let groups = await groupModule.getUserGroups(req.params.userId);
    groups.forEach(group => {
      patientIds.push(group.patients);
    });

    const uniquePatientIds = [...new Set(patientIds.map(i => i))];

    console.log(uniquePatientIds);

    let patients = await patientsModule.getPatients(uniquePatientIds);
    console.log(patients);

    if (patients.errors.length > 0) {
      console.error(patients.errors);
      return res.status(500).json(errors);
    } else {
      return res.json(patients.results);
    }
  } catch (e) {
    console.error(e);
    return res.status(500).json(e);
  }
};

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
