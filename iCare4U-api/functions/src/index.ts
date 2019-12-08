import * as functions from 'firebase-functions';
// lib/app.ts
import express = require('express');

// Create a new express application instance
const app: express.Application = express();

app.get('/', function (req, res) {
  res.send('Hello World!');
});


// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });



exports.api = functions.region('europe-west1').https.onRequest(app);