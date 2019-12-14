const functions = require('firebase-functions');
const app = require('express')();

// Create and Deploy Your First Cloud Functions
// https://firebase.google.com/docs/functions/write-firebase-functions

helloWorld = (request, response) => {
 response.send("Hello from iCare4U!");
};

app.get('/', helloWorld);

exports.api = functions.region('europe-west1').https.onRequest(app);
