const functions = require('firebase-functions');
const admin = require('firebase-admin');
const firestore = admin.firestore();
const stripe = require("stripe")("sk_live_D3waTgnBYHmFtryyOIaz3ZCM00KnD2hvoo");
//functions.config().stripe.key;
//admin.initializeApp();




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
 const customer = await stripe.accounts.create({ email: email ,country : 'US', type: 'standard', requested_capabilities: [
      'card_payments',
      'transfers',
    ] })
 return admin.firestore().collection('merchant').doc(data.id).update({ stripeId: customer.id})
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



  exports.makeCharge = functions.https.onCall( async (data, context) => {
    const customerId = data.customerId
    const totalAmount = data.total
    const idempotency = data.idempotency
    const paymentMethodId = data.payment_method_id
  
    return stripe.paymentIntents.create({
            payment_method: paymentMethodId,
            customer: customerId,
            amount: totalAmount,
            currency: 'usd',
            confirm: true,
            payment_method_types: ['card']
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