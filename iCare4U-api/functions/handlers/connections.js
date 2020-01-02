const { db } = require("../util/admin");

async function getPatientIdsByUserId(userId) {
  const connections = await db
    .collection("connections")
    .where("userId", "==", userId)
    .get();

  let patientIds = [];
  if (connections) {
    connections.docs.forEach(element => {
      patientIds.push(element.data().patientId);
    });
  }
  return patientIds;
}

async function getPatientsByIds(patientIds) {
  let patients = [];

  const data = await db
    .collection("patient")
    .where("patientId", "in", patientIds)
    .get();

  data.forEach(doc => {
    patients.push(doc.data());
  });

  return patients;
}

exports.getPatientsByUser = async (req, res) => {
  try {
    console.log(req.params);

    let patientIds = await getPatientIdsByUserId(req.params.userId);

    let patients = await getPatientsByIds(patientIds);

    return res.json(patients);
  } catch (e) {
    return res.status(500).json(e);
  }
};
