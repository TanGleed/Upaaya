
var admin = require("firebase-admin");

var serviceAccount = require('../../config/notify.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

exports.sendPushNotification = (message) => {
  admin.messaging().send(message)
  .then((response) => console.log('Successfully sent message:', response))
  .catch((error) => console.log('Error sending message:', error));
};
