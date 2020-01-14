const { db, admin } = require('../util/admin');

const {
  reducePatientDetails,
  validatePatientGroupData,
  validatePatientDetails
} = require('../util/validators');

const patientsModule = require('../modules/patients');
const groupModule = require('../modules/userGroups');

exports.getPatientsByUser = async (req, res) => {
  try {
    console.log(req.params);

    let patientIds = [];

    let groups = await groupModule.getUserGroups(req.params.userId);
    groups.forEach(group => {
      group.patients.forEach(p => {
        patientIds.push(p);
      });
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
    const data = await db.collection('patient').get();

    let items = [];
    data.docs.forEach(doc => {
      let patient = doc.data();
      patient.id = doc.id;
      items.push(patient);
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

    console.log(data.data());
    if (data.exists) {
      patientDetails = data.data();
      patientDetails.patientId = data.id;
      return res.status(200).json(patientDetails);
    } else {
      return res.status(404).json({ errror: 'Patient not found' });
    }
  } catch (e) {
    return res.status(500).json(e);
  }
};

exports.addPatientDetails = async (req, res) => {
  try {
    console.log(req.body);
    if (req.body.patientName.trim() === '') {
      return res.status(400).json({ body: 'Body must not be empty' });
    }

    let newPatient = reducePatientDetails(req.body);
    newPatient.createdAt = new Date().toISOString();

    const { errors, valid } = validatePatientDetails(newPatient);

    if (!valid) {
      return res.status(400).json(errors);
    }

    let doc = await db.collection('patient').add(newPatient);
    const resPatient = newPatient;
    resPatient.patientId = doc.id;

    return res.json(resPatient);
  } catch (e) {
    console.log(e);
    return res.status(500).json({ error: 'something went wrong' });
  }
};

exports.updatepatientDetails = async (req, res) => {
  try {
  } catch (e) {
    console.log(e);
    return res.status(500).json({ error: e.message });
  }
};

exports.addPatientIntoGroup = async (req, res) => {
  try {
    console.log(req.body);
    const { valid, errors } = validatePatientGroupData(req.body);

    if (!valid) return res.status(400).json(errors);

    let doc = db.collection('userGroups').doc(req.body.groupId);
    //console.log((await doc.get()).data());
    let arrUnion = await doc.update({
      patients: admin.firestore.FieldValue.arrayUnion(req.body.patientId)
    });

    console.log(arrUnion);

    return res.json(req.body);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ error: e.message });
  }
};

exports.deletePatient = async (req, res) => {
  try {
    await db
      .collection('patient')
      .doc(req.params.patientId)
      .delete();

    return res.status(200).json('Ok');
  } catch (e) {
    console.error(e);
    return res.status(500).json({ error: e.message });
  }
};
