
const notifyService = require('../services/notify.service');

exports.sendPushNotification = (req, res) => {
  const message = {
    notification: {
      title: "New worker",
      body: "New worker has enquired about the job"
    },
    data:{
      orderId: "123456",
      orderDate: "2022-10-28"
    },
    token: req.body.fcm_token,
  };
  
  notifyService.sendPushNotification(message);
  res.send("Notification sent");
};


