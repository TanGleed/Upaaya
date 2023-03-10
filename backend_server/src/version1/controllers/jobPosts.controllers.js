const jobPostsServices = require("../services/jobPosts.services");

const getJobPosts = (req, res) => {
  res.status(200).send(jobPostsServices.getJobPosts());
};

const getJobPost = (req, res) => {
  res.status(200).send("Get one workout");
};

const createJobPost = (req, res) => {
  res.status(200).send("Create a workout");
};

const updateJobPost = (req, res) => {
  res.status(200).send("update a existing workout");
};

const deleteJobPost = (req, res) => {
  res.status(200).send("Get a existing workout");
};

module.exports = {
  getJobPosts,
  getJobPost,
  createJobPost,
  updateJobPost,
  deleteJobPost,
};
