const functions = require('firebase-functions');
const admin = require('firebase-admin');
const firestore = admin.firestore();


exports.updateLocation = functions.firestore.document('merchant/{userId}').onUpdate(async(snap, context) => {

  const latitude = snap.latitude;
  const longitude = snap.longitude;
  const uid = context.auth.uid;

  if (uid === null) {
      console.log('Illegal access attempt due to unathenticated user');
      throw new functions.https.HttpsError('permission-denied', 'Illegal access attempt.')
    }
  
  let updatdeCoordinates = {
  google: new Firestore.GeoPoint(latitude, longitude)
  };
  
  let docRef = firestore.collection('merchant').document(uid)

  return docRef.update({ locationCoordinates: updatdeCoordinates })
});




exports.closeLocation = functions.https.onCall(async(data, context) => {

  const latitude = data.latitude
  const longitude = data.longitude
  const uid = context.auth.uid;

  if (uid === null) {
      console.log('Illegal access attempt due to unathenticated user');
      throw new functions.https.HttpsError('permission-denied', 'Illegal access attempt.')
  }

  let updatdCoordinates = {
  google: new Firestore.GeoPoint(latitude, longitude)
  };

  return admin.firestore().collection('merchant').doc(uid).update({ locationCoordinates: updatdCoordinates })
});                     

  //New Firestore.GeoPoint(latitude, longitude) is a constructuor, creating a new Google GeoPoint to store in the database. 
