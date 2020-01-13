const isEmail = email => {
  const regEx = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  if (email.match(regEx)) return true;
  else return false;
};

const isEmpty = string => {
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
