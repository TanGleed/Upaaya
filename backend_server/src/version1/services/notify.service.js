var admin = require("firebase-admin");
var fcm = require("fcm-notification");

var serviceAccount = require("../../config/notify.json");
const certPath = admin.credential.cert(serviceAccount);
var FCM = new fcm(certPath);

//send notification
async function sendPushNotification(params, callback) {
    try {
        var payload = {
            notification: {
                title: "Test Notification",
                body: "Notification message"
            },
            token: params.fcm_token,
            data: {
                orderId: "123456",
                orderDate: "2022-10-28"
            },

        }
        
        await FCM.send(payload, function (err, res) {
            if (err) {
               console.log(res);
               console.log(err);
                throw (err);
            }
            else
            {
                return callback(res);
            }
        });
    }
    catch (error) {
        return callback(error);
    }
}

module.exports = {
    sendPushNotification,
};