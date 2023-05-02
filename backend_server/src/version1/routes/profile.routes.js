const express = require("express");
const router = express.Router();
const middleware = require("../middleware/auth.middleware");
const profileController = require("../controllers/profile.controller");
const { upload }= require("../middleware/profile.middleware");
const profileModel = require("../../models/profile.model");

router.route("/add").post(middleware.authToken, profileController.addProfile);
router.route("/add/image").patch(middleware.authToken,
   upload.single("img"),
    profileController.updateProfileImage
  );

  router.route("/checkProfile").get(middleware.authToken,profileController.checkProfile);
module.exports = router;
