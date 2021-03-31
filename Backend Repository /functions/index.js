//Configuration for Firebase Functions 
const admin = require('firebase-admin');
admin.initializeApp();
const firestore = admin.firestore();
const functions = require('firebase-functions');
//Configuration for Node Server
const express = require('express');
const app = express();
app.use(express.json());

const { resolve } = require("path");
//Exporting functions from different pages
exports.notify = require('./notify');
exports.payments = require('./payments');
exports.location = require('./location');
exports.orders = require('./orders');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions


app.get("/", (req, res) => {
  // Display landing page.
  const path = resolve("./index.html");
  res.sendFile(path);
});
app.listen(4242, () => console.log(`Node server listening on port ${4242}!`));





