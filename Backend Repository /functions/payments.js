const functions = require('firebase-functions');
const admin = require('firebase-admin');
const firestore = admin.firestore();
const stripe = require("stripe")(functions.config().stripe.key);




//Each consumer will automatically get a Stripe account created for them upon signing up. Not called from the app, but from Firestore directly
exports.createStripeCustomer = functions.firestore.document('users/{userId}').onCreate(async (snap, context) => {
   const data = snap.data();
   const email = data.email;
   const customer = await stripe.customers.create({ email: email })
   return admin.firestore().collection('users').doc(data.id).update({ stripeId: customer.id})
  });

//Each Merchant will automatically get a Stripe account created for them upon signing up. Not called from the app, but from Firestore directly
exports.createStripeMerchant = functions.firestore.document('merchant/{userId}').onCreate(async (snap, context) => {
 const data = snap.data();
 const email = data.email;
 const customer = await stripe.accounts.create({ email: email ,country : 'US', type: 'express' })
 return admin.firestore().collection('merchant').doc(data.id).update({ stripeId: customer.id})
});

//
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

