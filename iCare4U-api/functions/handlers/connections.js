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

  var errors = [];
  var results = [];

  return Promise.all(queries)
    .then(items => {
      items.forEach(element => {
        results.push(element.data());
      });

      return {
        errors: errors,
        results: results
      };
    })
    .catch(e => {
      console.error(e);
      errors.push(e);
      return {
        errors: errors,
        results: results
      };
    });
}

exports.getPatientsByUser = async (req, res) => {
  try {
    console.log(req.params);

    let patientIds = await getPatientIdsByUserId(req.params.userId);

    let patients = await getPatients(patientIds);
    console.log(patients);
    if (patients.errors.length > 0) {
      console.error(patients.errors);
      return res.status(500).json(errors);
    } else {
      return res.json(patients.results);
    }
  } catch (e) {
    return res.status(500).json(e);
  }
};
