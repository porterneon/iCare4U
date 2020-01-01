const { db } = require("../util/admin");

const { getPatientDetails } = require("./patients");

exports.getPatientsByUser = async (req, res) => {
  try {
    console.log(req.params);
    const connections = await db
      .collection("connections")
      .where("userId", "==", req.params.userId)
      .get();

    let patientIds = [];
    if (connections) {
      connections.docs.forEach(element => {
        patientIds.push(element.data().patientId);
      });
    }

    let patients = [];

    const data = await db
      .collection("patient")
      .where("patientId", "in", patientIds)
      .get();

    data.forEach(doc => {
      patients.push(doc.data());
    });
    console.log(patients);
    return res.json(patients);
  } catch (e) {
    return res.status(500).json(e);
  }
};
