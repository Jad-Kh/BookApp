var admin = require("firebase-admin");

var serviceAccount = require("./bookapp-7c27c-firebase-adminsdk-fs713-966891775c.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: process.env.DATABASE_URL
});

const firebase = admin.firestore();
module.exports = { admin, firebase };