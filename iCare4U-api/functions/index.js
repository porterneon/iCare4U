const functions = require('firebase-functions');
const app = require('express')();
const FBAuth = require('./util/fbAuth');
const { db } = require('./util/admin');

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

helloWorld = (request, response) => {
 response.send("Hello from iCare4U!");
};

const {
    getAllUsers
  } = require('./handlers/users');

app.get('/', helloWorld);

app.get('/users', getAllUsers);

exports.api = functions.region('europe-west1').https.onRequest(app);
