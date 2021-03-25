const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const app = express();
app.use(express.json());
const { resolve } = require("path");
const notify = require('./notify');
exports.notify = notify.test;
exports.notifyCustomer = notify.orderCreated
exports.orderAccepted = notify.orderAccepted
admin.initializeApp();
const firestore = admin.firestore();
const stripe = require("stripe")(functions.config().stripe.key);

// const location = require('./location');
// exports.location = location.updateLocation
//exports.closeLocation = location.closeLocation
//serviceAccount = require('./serviceAccount.json');

// const adminConfig = JSON.parse(process.env.FIREBASE_CONFIG);
// adminConfig.credential = admin.credential.cert(serviceAccount);
//exports.stripe = require('./payments');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
//functions.config().stripe.seceret_test_key
//const stripe = require("stripe")("sk_test_rKhIPOAfQ7A9el8L570woVpR00q861QZVx");

app.get("/", (req, res) => {
  // Display landing page.
  const path = resolve("./index.html");
  res.sendFile(path);
});

app.get("/connect/oauth", async (req, res) => {
  const { code, state } = req.query;

  // Assert the state matches the state you provided in the OAuth link (optional).
  if(!stateMatches(state)) {
    return res.status(403).json({ error: 'Incorrect state parameter: ' + state });
  }

  // Send the authorization code to Stripe's API.
  stripe.oauth.token({
    grant_type: 'authorization_code',
    code: code
  }).then(
    (response) => {
      var connected_account_id = response.stripe_user_id;
      saveAccountId(connected_account_id);

      // Render some HTML or redirect to a different page.
      return res.status(200).json({success: true});
    })
    .catch((err) => {
      if (err.type === 'StripeInvalidGrantError') {
        return res.status(400).json({error: 'Invalid authorization code: ' + code});
      } else {
        return res.status(500).json({error: 'An unknown error occurred.'});
      }
    });

});

const stateMatches = (state_parameter) => {
  // Load the same state value that you randomly generated for your OAuth link.
  const saved_state = state;

  return saved_state === state_parameter;
}

const saveAccountId = (id) => {
  // Save the connected account ID from the response to your database.
  console.log('Connected account ID: ' + id);
}

app.listen(4242, () => console.log(`Node server listening on port ${4242}!`));


exports.merchantOnboarding = functions.https.onRequest(app);

exports.createStripeCustomer = functions.firestore.document('users/{userId}').onCreate(async (snap, context) => {
   const data = snap.data();
   const email = data.email;
   const customer = await stripe.customers.create({ email: email })
   return admin.firestore().collection('users').doc(data.id).update({ stripeId: customer.id})

  });

exports.createStripeMerchant = functions.firestore.document('merchant/{userId}').onCreate(async (snap, context) => {
 const data = snap.data();
 const email = data.email;
 const customer = await stripe.accounts.create({ email: email ,country : 'US', type: 'express' })
 return admin.firestore().collection('merchant').doc(data.id).update({ stripeId: customer.id})
});


exports.createAccountsLink = functions.https.onCall( async ( data, context) => {
  const account = data.stripeId;

const accountLink = await stripe.accountLinks.create({
  account: account,
  refresh_url: 'https://gulpmerchant.page.link/stripeconnect',
  return_url: 'https://gulpmerchant.page.link/stripeconnect',
  type: 'account_onboarding',
});
return accountLink.url
})

exports.updatePayoutDate = functions.https.onCall( async ( data, context ) => {
const stripeID = data.stripeId;
const day = data.day

  const account = await stripe.accounts.update(
    'acct_1IXrdzQfQzdPjHUl',
    {settings: {payouts: { schedule : {interval : 'weekly' , weekly_anchor: day}}}}
  );
return account
})



exports.makeCharge = functions.https.onCall( async (data, context) => {
  const customerId = data.customerId
  const stripeId  = data.stripeId
  const customerEmail = data.customerEmail
  const totalAmount = data.total
  const idempotency = data.idempotency
  const paymentMethodId = data.payment_method_id
  const application_fee_amount = data.application_fee_amount

  return stripe.paymentIntents.create({
          payment_method: paymentMethodId,
          customer: customerId,
          amount: totalAmount,
          receipt_email: customerEmail,
          currency: 'usd',
          confirm: true,
          payment_method_types: ['card'],
          application_fee_amount: application_fee_amount,
          transfer_data: {
            destination: stripeId
          }
      }, {
              idempotency_key: idempotency
          }).then(intent => {
              console.log('Charge Success: ', intent)
              return
          }).catch(err => {
              console.log(err);
              throw new functions.https.HttpsError('internal', ' Unable to create charge: ' + err);
          });
  });




exports.createEphemeralKey = functions.https.onCall(async(data, context) => {

  const customerId = data.customer_id;
  const stripeVersion = data.apiVersion;
  const uid = context.auth.uid;

  if (uid === null) {
      console.log('Illegal access attempt due to unathenticated user');
      throw new functions.https.HttpsError('permission-denied', 'Illegal access attempt.')
  }

  return stripe.ephemeralKeys.create(
    {customer: customerId},
    {apiVersion: stripeVersion}
  ).then((key) => {
    return key
  }).catch((err) => {
    console.log(err)
    throw new functions.https.HttpsError('internal', 'Unable to create ephemeral key.')
  })
});

exports.updateLocation = functions.firestore.document('merchant/{userId}').onUpdate(async(snap, context) => {

  const latitude = snap.latitude;
  const longitude = snap.longitude;
  const uid = context.auth.uid;

  if (uid === null) {
      console.log('Illegal access attempt due to unathenticated user');
      throw new functions.https.HttpsError('permission-denied', 'Illegal access attempt.')
  }
  //the notation new Firestore.GeoPoint is a constructor that creates a new GeoPoint. This has to be done on the server level. You cannot send a geopoint from swift to back end, only a primitive data payment_method_types
  let updatdeCoordinates = {
  google: new Firestore.GeoPoint(latitude, longitude)
};
let docRef = firestore.collection('merchant').document(uid)

  return docRef.update({ locationCoordinates: updatdeCoordinates })
});
