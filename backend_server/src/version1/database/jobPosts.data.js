// Description: This file contains the database functions for the jobPosts model

// Import the jobPost model
const JobPost = require("../../models/jobPosts.model");

// Create the getJobPosts function
const getJobPosts = (params) => {
  return Promise.resolve(JobPost.find() || null);
};

// Create the createJobPost function
const createJobPost = (jobPost, params) => {
  return Promise.resolve(jobPost.save() || null);
};

module.exports = {
  getJobPosts,
  createJobPost,
};
