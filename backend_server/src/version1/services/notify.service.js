var admin= require("firebase-admin");
var fcm= require("fcm-node");

var serviceAccount= require("../../config/notify.json");
const certPath= admin.credential.cert(serviceAccount);
var FCM= new fcm(certPath);

//send notification
async function sendPushNotification(params,callback){
    try{
        let message= {
            notification:{
                title:"Test Notification",
                body:"Notification message"
            },
            data:{
                orderId: "123456",
                orderDate: "2022-10-28"
            },
            token: req.body.fcm_token,
        };
        FCM.send(message, function(err, res){
            if(err){
                throw(err);
            }
            else{
                return callback(res);
            }
        });
    }
    catch(error)
    {
        return callback(error);
    }
}

module.exports ={
    sendPushNotification,
};