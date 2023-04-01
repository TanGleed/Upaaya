//const JOBS = require("../../models/jobs.json");
//const mongoose = require("mongoose");
const JobPost = require("../../models/jobPosts.model");

const getJobPosts = (params) => {
  return Promise.resolve(JobPost.find() || null);
};

const createJobPost = (newJobPost, params) => {
  // const jobPost = { ...newJobPost };
  // return jobPost.save();
};

module.exports = {
  getJobPosts,
  createJobPost,
};
