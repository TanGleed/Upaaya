const express = require("express");
const router = express.Router();

const categoryController =require("../controllers/categories.controller");

router.post("/",categoryController.create);
router.get("/",categoryController.findAll);
router.get("/:id",categoryController.findOne);
router.put("/:id" ,categoryController.update);
router.delete("/:id" ,categoryController.delete);



module.exports =router;