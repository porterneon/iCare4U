const groupModule = require("../modules/userGroups");

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
