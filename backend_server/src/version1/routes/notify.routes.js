const sendPushNotificationController= require("../controllers/notify.controller");
const express= require("express");
const router= express.Router();

router.post("/send-notification", sendPushNotificationController.sendPushNotification);

module.exports= router; 