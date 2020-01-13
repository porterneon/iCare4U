const { db, admin } = require("../util/admin");
const groupModule = require("../modules/userGroups");

const { validateUserGroupPayload } = require("../util/validators");

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
