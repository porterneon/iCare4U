const { db } = require('../util/admin');

async function getUserGroups(userId) {
  const data = await db
    .collection('userGroups')
    .where('userIds', 'array-contains', userId)
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
    .collection('userGroups')
    .where('userIds', 'array-contains-any', ids)
    .get();

  let patientIds = [];
  data.forEach(doc => {
    console.log(doc.data());
    patientIds.push(doc.data());
  });

  return patientIds;
}

async function getUserGroupByName(groupName, ownerId) {
  try {
    return await db
      .collection('userGroups')
      .where('groupName', '==', groupName)
      .where('ownerId', '==', ownerId)
      .get();
  } catch (e) {
    console.error(e);
  }
}

async function addUserGroup(data) {
  let errors = [];
  let result = {};

  try {
    let entities = await getUserGroupByName(data.groupName, data.ownerId);

    console.log(entities.docs.length);

    if (entities.docs.length > 0) {
      errors.push({ error: 'this user group is already taken' });
    } else {
      let doc = await db.collection('userGroups').add(data);

      result.id = doc.id;
    }
  } catch (e) {
    errors.push(e);
  }

  return {
    errors: errors,
    result: result,
    valid: Object.keys(errors).length === 0 ? true : false
  };
}

async function deleteUserGroup(groupName, ownerId) {
  let queries = [];

  let entities = await getUserGroupByName(groupName, ownerId);

  entities.forEach(e => {
    queries.push(
      db
        .collection('userGroups')
        .doc(e.id)
        .delete()
    );
  });

  var errors = [];
  var results = [];

  await Promise.all(queries)
    .then(items => {
      items.forEach(element => {
        results.push(element);
      });
    })
    .catch(e => {
      console.error(e);
      errors.push(e);
    });

  return {
    errors: errors,
    results: results,
    valid: Object.keys(errors).length === 0 ? true : false
  };
}

module.exports = {
  getUserGroups,
  getPatientsIds,
  addUserGroup,
  getUserGroupByName,
  deleteUserGroup
};
