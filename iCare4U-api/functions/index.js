const functions = require('firebase-functions');
const app = require('express')();
const FBAuth = require('./util/fbAuth');

helloWorld = (request, response) => {
  response.send('Hello from iCare4U!');
};

const {
  signup,
  login,
  uploadImage,
  getAllUsers,
  addUserDetails,
  getAuthenticatedUser,
  getUserDetails
} = require('./handlers/users');

const {
  getAllPatients,
  getPatientDetails,
  addPatientDetails,
  getPatientsByUser,
  addPatientIntoGroup,
  deletePatient
} = require('./handlers/patients');

const {
  getGroupByUserId,
  addUserGroup,
  deleteUserGroup
} = require('./handlers/userGroups');

app.get('/', helloWorld);

// Users routes
app.post('/signup', signup);
app.post('/login', login);
app.post('/user/image', FBAuth, uploadImage);
app.get('/users', FBAuth, getAllUsers);
app.post('/user', FBAuth, addUserDetails);
app.get('/user', FBAuth, getAuthenticatedUser);
app.get('/user/:handle', FBAuth, getUserDetails);

// Patients routes
app.get('/patients', getAllPatients);
app.get('/patients/:patientId', getPatientDetails);
app.get('/patientsByUserId/:userId', getPatientsByUser);
app.post('/patients', FBAuth, addPatientDetails);
app.post('/addPatientIntoGroup', FBAuth, addPatientIntoGroup);
app.delete('/patients/:patientId', deletePatient);

// user groups
app.get('/groupsByUserId/:userId', FBAuth, getGroupByUserId);
app.post('/userGroup', FBAuth, addUserGroup);
app.delete('/userGroup', FBAuth, deleteUserGroup);

exports.api = functions.region('europe-west1').https.onRequest(app);
