const groupModule = require('../modules/userGroups');

const {
  validateUserGroupPayload,
  validateUserIntoGroupData
} = require('../util/validators');

exports.getGroupByUserId = async (req, res) => {
  try {
    console.log(req.params.userId);
    let data = await groupModule.getUserGroups(req.params.userId);

    console.log(data);
    return res.json(data);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e);
  }
};

exports.addUserGroup = async (req, res) => {
  const { valid, errors } = validateUserGroupPayload(req.body);

  if (!valid) return res.status(400).json(errors);

  try {
    const { errors, result, valid } = await groupModule.addUserGroup(req.body);

    if (valid) {
      return res.status(200).json(result);
    } else {
      return res.status(400).json(errors);
    }
  } catch (e) {
    console.error(e);
    return res.status(500).json(e);
  }
};

exports.deleteUserGroup = async (req, res) => {
  try {
    const { errors, results, valid } = await groupModule.deleteUserGroup(
      req.body.groupName,
      req.body.ownerId
    );

    if (!valid) return res.status(400).json(errors);

    return res.status(200).json(results);
  } catch (e) {
    console.error(e);
    return res.status(500).json(e);
  }
};

exports.addUserIntoGroup = async (req, res) => {
  try {
    console.log(req.body);
    const { valid, errors } = validateUserIntoGroupData(req.body);

    if (!valid) return res.status(400).json(errors);

    let doc = db.collection('userGroups').doc(req.body.groupId);
    //console.log((await doc.get()).data());
    let arrUnion = await doc.update({
      userIds: admin.firestore.FieldValue.arrayUnion(req.body.userId)
    });

    console.log(arrUnion);

    return res.json(req.body);
  } catch (e) {
    console.error(e);
    return res.status(500).json({ error: e.message });
  }
};
