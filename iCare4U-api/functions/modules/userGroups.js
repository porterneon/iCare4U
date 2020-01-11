const { db } = require("../util/admin");

async function getUserGroups(userId) {
  const data = await db
    .collection("userGroups")
    .where("userIds", "array-contains", userId)
    .get();

  let groups = [];
  data.forEach(doc => {
    //console.log(doc.data());
    groups.push(doc.data());
  });

  return groups;
}

async function getPatientsIds(ids) {
  const data = await db
    .collection("userGroups")
    .where("userIds", "array-contains-any", ids)
    .get();

  let patientIds = [];
  data.forEach(doc => {
    console.log(doc.data());
    patientIds.push(doc.data());
  });

  return patientIds;
}

module.exports = {
  getUserGroups,
  getPatientsIds
};
