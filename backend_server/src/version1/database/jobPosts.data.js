//const JOBS = require("../../models/jobs.json");
//const mongoose = require("mongoose");
const JobPost = require("../../models/jobPosts.model");

const getJobPosts = () => {
  return Promise.resolve(JobPost.find() || null);
};

const createJobPost = async (newJobPost) => {
  const JobPost = { ...newJobPost };

  return insertedJobPost;
};

module.exports = {
  getJobPosts,
  createJobPost,
};
