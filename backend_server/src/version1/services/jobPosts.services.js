const jobPostsData = require("../database/jobPosts.data");

const getJobPosts = () => {
  return jobPostsData.getJobPosts();
};

module.exports = {
  getJobPosts,
};
