const express = require("express");
const router = express.Router();
const Controller =require("../controllers/profile.controller");

router.post("/add",Controller.addProfile);
router.post("/getuser",Controller.getUserProfile);
router.post("/updateuser" ,Controller.updateuserprofile);
router.post("/updateimg" ,Controller.uploadimage);
module.exports = router;