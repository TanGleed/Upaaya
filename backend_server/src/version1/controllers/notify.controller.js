// var admin= require("firebase-admin");
// var fcm= require("fcm-node");

// var serviceAccount= require("../../config/notify.json");
// const certPath= admin.credential.cert(serviceAccount);
// var FCM= new fcm(certPath);
const notifyservice= require("../services/notify.service");
// exports.sendPushNotification =(req, res, next)=> {
//     try{
//         let message= {
//             notification:{
//                 title:"Test Notification",
//                 body:"Notification message"
//             },
//             data:{
//                 orderId: "123456",
//                 orderDate: "2022-10-28"
//             },
//             token: req.body.fcm_token,
//         };

//         FCM.send(message, function(err, resp){
//             if(err){
//                 return res.status(500).send({
//                     message: "Notification Sent"
//                 });
//             }
//             else{
//                 return res.status(200).send({
//                     message: "Notification Sent"
//                 });
//             }
//         });
//     }
//     catch(err){
//         throw err;
//     }
// }
exports.sendPushNotification = (req,res,next)=>
{
    notifyservice.sendPushNotification(
        req.body,
        (error,result)=>
        {
            if(error)
            {
                console.log(error); 
                return next(error);
            }
            else
            {
                return res.status(200).send(
                    {
                    message:"Success",
                    data:result,
                    }
                );
            }
        }
    )
}