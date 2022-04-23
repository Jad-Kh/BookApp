var admin = require("firebase-admin");

var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://bookapp-7c27c-default-rtdb.europe-west1.firebasedatabase.app"
});

const db = admin.firestore();
module.exports = { admin, db };