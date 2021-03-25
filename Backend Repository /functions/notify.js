const functions = require('firebase-functions');
const accountSid = functions.config().twilio.accountsid;
const authToken = functions.config().twilio.authtoken;
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

exports.orderCreated = functions.https.onCall( async (data , context) => {
  const customerPhoneNumber = data.phoneNumber;
  return client.messages.create({
    body: 'Thanks for your order! You can grab your food in 10 minutes',
    to: customerPhoneNumber,  // Text this number
    from: '+12246287287' // From a valid Twilio number
})
.then(message => {
  console.log(message.sid)
  return
}).catch(err => {
    console.log(err);
    throw new functions.https.HttpsError('internal', ' Unable to create charge: ' + err);
});
});

exports.orderAccepted = functions.https.onCall( async (data , context) => {
  const customerPhoneNumber = data.phoneNumber;
  const truckName = data.truckName
  return client.messages.create({
    body: `Your order from ${truckName} has been confirmed! The food will be ready in 5 minutes`,
    to: customerPhoneNumber,  // Text this number
    from: '+12246287287' // From a valid Twilio number
})
.then(message => {
  console.log(message.sid)
  return
}).catch(err => {
    console.log(err);
    throw new functions.https.HttpsError('internal', ' Unable to create charge: ' + err);
});
});
