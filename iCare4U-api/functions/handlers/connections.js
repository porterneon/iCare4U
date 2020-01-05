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

async function getPatients(ids) {
  let queries = [];
  ids.forEach(id => {
    queries.push(db.doc(`/patient/${id}`).get());
  });

  return Promise.all(queries)
    .then(items => {
      let patients = [];
      items.forEach(element => {
        patients.push(element.data());
      });

      return patients;
    })
    .catch(e => {
      console.error(e);
      return [];
    });
}

exports.getPatientsByUser = async (req, res) => {
  try {
    console.log(req.params);

    let patientIds = await getPatientIdsByUserId(req.params.userId);

    let p = await getPatients(patientIds);
    console.log(p);

    return res.json(p);
  } catch (e) {
    return res.status(500).json(e);
  }
};
