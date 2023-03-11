const JOBS = require("../../models/jobs.json");

const getJobPosts = () => {
  return JOBS.jobs;
};

module.exports = {
  getJobPosts,
};
