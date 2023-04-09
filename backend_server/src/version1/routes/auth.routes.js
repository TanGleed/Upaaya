const express = require("express");
const router = express.Router();

const Controller =require("../controllers/auth.controller");
const { authToken } = require("../middleware/auth.middleware");

router.post("/register" ,Controller.register);
router.post("/uniqueemail", Controller.uniqueemail);
router.post("/sendOTP",Controller.sendOTP);
router.post("/verifyOTP",Controller.verifyOTP);
router.post("/login",Controller.login);
router.post("/resetpassword",Controller.resetpassword);

module.exports = router;