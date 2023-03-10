const express = require("express");

const jobPostsController = require("../controllers/jobPosts.controllers");

const router = express.Router();

const { getJobPosts, getJobPost, createJobPost, updateJobPost, deleteJobPost } =
  jobPostsController;

router.route("/").get(getJobPosts).post(createJobPost);
router.route("/:id").get(getJobPost).put(updateJobPost).delete(deleteJobPost);

module.exports = router;
