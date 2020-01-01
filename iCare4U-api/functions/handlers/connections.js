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

    console.log(patientIds);

    let patients = [];
    patientIds.forEach(async id => {
      //   const data = await db
      //     .collection("patient")
      //     .where("patientId", "==", id)
      //     .get();

      //   data.forEach(doc => {
      //     patients.push(doc.data());
      //   });

      const data = await db.doc(`/patient/${id}`).get();

      console.log(data.data());
      if (data.exists) {
        patients.push({
          patientId: data.data().patientId,
          height: data.data().height
        });

        console.log(patients);
      }
    });

    return res.json(patients);
  } catch (e) {
    return res.status(500).json(e);
  }
};
