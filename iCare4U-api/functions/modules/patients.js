const { db } = require("../util/admin");

async function removePatientMedicine(patientId, id) {
  var errors = [];
  try {
    let patientRef = db.collection("patient").doc(patientId);

    await patientRef.update({
      medicines: admin.firestore.FieldValue.arrayRemove(id)
    });
  } catch (e) {
    console.error(e);
    errors.push(e);
  }

  return {
    errors: errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
}

async function removePatientSchedule(patientId, id) {
  var errors = [];
  try {
    let patientRef = db.collection("patient").doc(patientId);

    await patientRef.update({
      schedules: admin.firestore.FieldValue.arrayRemove(id)
    });
  } catch (e) {
    console.error(e);
    errors.push(e);
  }

  return {
    errors: errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
}

module.exports = {
  removePatientMedicine,
  removePatientSchedule
};
