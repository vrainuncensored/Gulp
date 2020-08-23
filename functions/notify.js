const functions = require('firebase-functions');
const accountSid = 'AC25a7e9a9d2f099bdc418f315b914e3ad';
const authToken = functions.config().twilio.key;
const client = require('twilio')(accountSid, authToken);
var twilio = require('twilio');




exports.test = functions.https.onCall( async (request, response) => {
  return client.messages.create({
    body: 'Welcome to Gulp! You can now order from your favorite food trucks',
    to: '+17038191285',  // Text this number
    from: '+12029528407' // From a valid Twilio number
})
.then(message => {
  console.log(message.sid)
  return
}).catch(err => {
    console.log(err);
    throw new functions.https.HttpsError('internal', ' Unable to create charge: ' + err);
});
});
