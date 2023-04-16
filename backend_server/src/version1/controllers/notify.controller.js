var admin = require("firebase-admin");

var serviceAccount = require('../../config/notify.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

exports.sendPushNotification=(req)=>{
const message = {
  notification: {
    title: "FCM Test",
    body: "This is a test FCM message",
  },
  data:{
       orderId: "123456",
       orderDate: "2022-10-28"
     },
  token: req.body.fcm_token,
    };

  admin.messaging().send(message)
  .then((response) => console.log('Successfully sent message:', response))
  .catch((error) => console.log('Error sending message:', error));
};



