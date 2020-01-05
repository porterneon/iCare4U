const { db } = require("../util/admin");

const getPatientIdsByUserId = async userId => {
  try {
    console.log(">>> getPatientIdsByUserId <<<");
    console.log(`userId: ${userId}`);
    const connections = await db
      .collection("connections")
      .where("userId", "==", userId)
      .get();

    let patientIds = [];
    if (connections) {
      connections.docs.forEach(element => {
        console.log(element.data());
        patientIds.push(element.data().patientId);
      });
    }

    console.log(patientIds);
    return patientIds;
  } catch (err) {
    console.error(err);
  }
};

module.exports = {
  getPatientIdsByUserId
};
