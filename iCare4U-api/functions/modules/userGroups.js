const { db } = require("../util/admin");

async function getUserGroups(id) {
  const data = await db
    .collection("userGroups")
    .where("userIds", "array-contains", id)
    .get();

  let groups = [];
  data.forEach(doc => {
    //console.log(doc.data());
    groups.push(doc.data());
  });

  return groups;
}

module.exports = {
  getUserGroups
};
