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
  getPatientDetails
} = require("./handlers/patients");

const {
  getPatientsByUser
} = require("./handlers/connections");

app.get("/", helloWorld);

// Users routes
app.post("/signup", signup);
app.post("/login", login);
app.post("/user/image", FBAuth, uploadImage);
app.get("/users", FBAuth, getAllUsers);
app.post("/user", FBAuth, addUserDetails);
app.get("/user", FBAuth, getAuthenticatedUser);
app.get("/user/:handle", getUserDetails);

// Patients routes
app.get("/patients", FBAuth, getAllPatients);
app.get("/patients/:patientId",FBAuth, getPatientDetails);
app.get("/patientsByUserId/:userId", getPatientsByUser);

exports.api = functions.region("europe-west1").https.onRequest(app);
