const functions = require("firebase-functions");
const app = require("express")();
const FBAuth = require("./util/fbAuth");

helloWorld = (request, response) => {
  response.send("Hello from iCare4U!");
};

const {
  signup,
  login,
  uploadImage,
  getAllUsers,
  addUserDetails,
  getAuthenticatedUser,
  getUserDetails
} = require("./handlers/users");

const {
  getAllPatients,
  getPatientDetails,
  addPatientDetails,
  getPatientsByUser,
  addPatientIntoGroup,
  deletePatient,
  updatePatientDetails
} = require("./handlers/patients");

const {
  getGroupByUserId,
  addUserGroup,
  deleteUserGroup,
  addUserIntoGroup
} = require("./handlers/userGroups");

const {
  addMedicine,
  deleteMedicine,
  getMedicineById,
  updateMedicine,
  getMedicinesByPatient
} = require("./handlers/medicines");

const {
  addSchedule,
  deleteSchedule,
  getScheduleById,
  updateSchedule,
  getSchedulesByPatient
} = require("./handlers/schedules");

app.get("/", helloWorld);

// Users routes
app.post("/signup", signup);
app.post("/login", login);
app.post("/user/image", FBAuth, uploadImage);
app.get("/users", FBAuth, getAllUsers);
app.post("/user", FBAuth, addUserDetails);
app.get("/user", FBAuth, getAuthenticatedUser);
app.get("/user/:handle", FBAuth, getUserDetails);

// Patients routes
app.get("/patients", FBAuth, getAllPatients);
app.get("/patients/:patientId", FBAuth, getPatientDetails);
app.get("/patientsByUserId/:userId", FBAuth, getPatientsByUser);
app.post("/patients", FBAuth, addPatientDetails);
app.post("/addPatientIntoGroup", FBAuth, addPatientIntoGroup);
app.delete("/patients/:patientId", FBAuth, deletePatient);
app.post("/patients/:patientId", FBAuth, updatePatientDetails);

// user groups
app.get("/groupsByUserId/:userId", FBAuth, getGroupByUserId);
app.post("/userGroup", FBAuth, addUserGroup);
app.delete("/userGroup", FBAuth, deleteUserGroup);
app.post("/userGroup/addUserIntoGroup", FBAuth, addUserIntoGroup);

// medicines
app.get("/medicines/:medicineId", FBAuth, getMedicineById);
app.post("/medicines/:patientId", FBAuth, addMedicine);
app.post("/medicines/:medicineId", FBAuth, updateMedicine);
app.delete("/medicines", FBAuth, deleteMedicine);
app.get("/medicinesByPatientId/:patientId", getMedicinesByPatient);

// schedules
app.get("/schedules/:scheduleId", FBAuth, getScheduleById);
app.post("/schedules/:patientId", FBAuth, addSchedule);
app.post("/schedules/:scheduleId", FBAuth, updateSchedule);
app.delete("/schedules", FBAuth, deleteSchedule);
app.get("/schedulesByPatientId/:patientId", FBAuth, getSchedulesByPatient);

exports.api = functions.region("europe-west1").https.onRequest(app);
