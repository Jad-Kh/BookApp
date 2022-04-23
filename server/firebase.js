const firebase = require('firebase');

const firebaseConfig = {
    apiKey: "AIzaSyCiNg3XY_B5gy6kyto6nkrxVgh_AcQxrK4",
    authDomain: "bookapp-7c27c.firebaseapp.com",
    databaseURL: "https://bookapp-7c27c-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "bookapp-7c27c",
    storageBucket: "bookapp-7c27c.appspot.com",
    messagingSenderId: "292711585769",
    appId: "1:292711585769:web:ec5ae2e9a9d34b5b699d78",
    measurementId: "G-W2F6WLYJ9G"
};

  firebase.initializeApp(firebaseConfig);
  
  module.exports = { firebase };