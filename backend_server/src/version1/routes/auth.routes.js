const express = require("express");
const router = express.Router();

const Controller =require("../controllers/auth.controller");

router.post("/register" ,Controller.register);

module.exports = router;