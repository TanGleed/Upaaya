// Description: This file contains all the routes for the jobPosts resource.

// Import the express router
const express = require("express");

// Import the jobPosts controller
const jobPostsController = require("../controllers/jobPosts.controllers");

// Create the router
const router = express.Router();

// Destructure the jobPosts controller
const { getJobPosts, getJobPost, createJobPost, updateJobPost, deleteJobPost } =
  jobPostsController;

// Create the routes
router.route("/").get(getJobPosts).post(createJobPost);
router.route("/:id").get(getJobPost).put(updateJobPost).delete(deleteJobPost);

// Export the router
module.exports = router;
