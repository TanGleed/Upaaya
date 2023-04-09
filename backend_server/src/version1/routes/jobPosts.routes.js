// Description: This file contains all the routes for the jobPosts resource.

// Import the express router
const express = require("express");

// Import the jobPosts controller
const jobPostsController = require("../controllers/jobPosts.controllers");
const handleUpload = require("../middleware/jobPost.middleware");

// Create the router
const router = express.Router();

// Destructure the jobPosts controller
const { getJobPosts, getJobPost, createJobPost, updateJobPost, deleteJobPost } =
  jobPostsController;

// Create the routes
router.get("/", getJobPosts); // GET /api/v1/jobPosts
router.get("/:id", getJobPost); // GET /api/v1/jobPosts/:id
router.post("/", createJobPost); // POST /api/v1/jobPosts
router.put("/:id", updateJobPost); // PUT /api/v1/jobPosts/:id
router.delete("/:id", deleteJobPost); // DELETE /api/v1/jobPosts/:id

// Export the router
module.exports = router;
