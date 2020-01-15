const isEmail = email => {
  const regEx = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  if (email.match(regEx)) return true;
  else return false;
};

exports.isEmpty = string => {
  if (string === undefined || string.trim() === "") return true;
  else return false;
};

const isArray = what => {
  return Object.prototype.toString.call(what) === "[object Array]";
};

exports.validatePatientGroupData = data => {
  let errors = {};
  if (isEmpty(data.groupId)) errors.groupId = "Must not be empty";

  if (isEmpty(data.patientId)) errors.patientId = "Must not be empty";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.validateSignupData = data => {
  let errors = {};
  if (isEmpty(data.email)) {
    errors.email = "Mast not be empty";
  } else if (!isEmail(data.email)) {
    errors.email = "Must be a valid email address";
  }

  if (isEmpty(data.password)) errors.password = "Must not be empty";
  if (data.password !== data.confirmPassword)
    errors.confirmPassword = "Password must match";
  if (isEmpty(data.userName)) errors.userName = "Must not be empty";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.validateLoginData = data => {
  let errors = {};

  if (isEmpty(data.email)) errors.email = "Must not be empty";
  if (isEmpty(data.password)) errors.password = "Must not be empty";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.reduceUserDetails = data => {
  let userDetails = {};

  if (!isEmpty(data.bio.trim())) userDetails.bio = data.bio;

  if (!isEmpty(data.website.trim())) {
    if (data.website.trim().substring(0, 4) !== "http") {
      userDetails.website = `http://${data.website.trim()}`;
    } else userDetails.website = data.website.trim();
  }

  if (!isEmpty(data.location.trim())) userDetails.location = data.location;

  return userDetails;
};

exports.reducePatientDetails = data => {
  let patientDetails = {};

  if (!isEmpty(data.height.trim())) patientDetails.height = data.height;
  if (!isEmpty(data.heightUom.trim()))
    patientDetails.heightUom = data.heightUom;
  if (!isEmpty(data.age.trim())) patientDetails.age = data.age;
  if (!isEmpty(data.weight.trim())) patientDetails.weight = data.weight;
  if (!isEmpty(data.patientName.trim()))
    patientDetails.patientName = data.patientName;
  if (!isEmpty(data.weightUom.trim()))
    patientDetails.weightUom = data.weightUom;

  return patientDetails;
};

exports.validatePatientDetails = data => {
  let errors = {};

  if (!isEmpty(data.patientName)) errors.patientName = "Must not be empty";
  if (!isArray(data.medicines)) errors.medicines = "Must be an array";
  if (!isArray(data.schedules)) errors.schedules = "Must be an array";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.validateUserIntoGroupData = data => {
  let errors = {};

  if (!isEmpty(data.groupId)) errors.groupId = "Must not be empty";
  if (!isEmpty(data.userId)) errors.userId = "Must not be empty";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.validateUserGroupPayload = data => {
  let errors = {};

  if (isEmpty(data.groupName)) errors.groupName = "Must not be empty";
  if (isEmpty(data.ownerId)) errors.ownerId = "Must not be empty";

  if (data.patients == "undefined") errors.patients = "Must be an array";
  if (data.userIds == "undefined") errors.userIds = "Must be an array";

  if (!isArray(data.patients)) errors.patients = "Must be an array";
  if (!isArray(data.userIds)) errors.userIds = "Must be an array";

  if (!data.userIds.some(item => item === data.ownerId))
    errors.userIds = "Must contain at least one owner id";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

// Medicine
exports.validateAddMedicinePayload = data => {
  let errors = {};

  if (isEmpty(data.itemName)) errors.itemName = "Must not be empty";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.validateDeleteMedicinePayload = data => {
  let errors = {};

  if (isEmpty(data.patientId)) errors.patientId = "Must not be empty";
  if (isEmpty(data.medicineId)) errors.medicineId = "Must not be empty";

  return {
    errors,
    valid: Object.keys(errors).length === 0 ? true : false
  };
};

exports.reduceMedicineDetails = data => {
  let details = {};

  if (!isEmpty(data.itemName.trim())) details.itemName = data.itemName;
  if (!isEmpty(data.itemDescription.trim()))
    details.itemDescription = data.itemDescription;
  if (!isEmpty(data.imageUrl.trim())) details.imageUrl = data.imageUrl;
  if (!isEmpty(data.createdAt.trim())) details.createdAt = data.createdAt;

  return details;
};
