const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sayHello = functions.https.onCall((data, context) => {
  const name = data.name || 'User';
  console.log('sayHello called with:', name);
  return { message: `Hello, ${name}!` };
});

exports.newUserCreated = functions.firestore
  .document('users/{userId}')
  .onCreate(async (snap, context) => {
    const data = snap.data();
    console.log('New user created:', data);
    const docRef = snap.ref;
    if (!data || !data.createdAt) {
      return docRef.set({ createdAt: admin.firestore.FieldValue.serverTimestamp() }, { merge: true });
    }
    return null;
  });
