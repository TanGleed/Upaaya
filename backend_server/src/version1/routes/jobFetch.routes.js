const express = require('express');
const router = express.Router();
const jobController = require('../controllers/jobFetch.controller');

router.get('/', jobController.getAllJobs);

module.exports = router;