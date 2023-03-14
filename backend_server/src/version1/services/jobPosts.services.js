const jobPostsData = require("../database/jobPosts.data");

const getJobPosts = async (params) => {
  try {
    const allJobPosts = await jobPostsData.getJobPosts(params);
    return allJobPosts;
  } catch (err) {
    return null;
  }
};

const createJobPost = (newJobPost) => {
  const serviceInsertedJobPost = { ...newJobPost };

  try {
    const createdJobPost = jobPostsData.createJobPost(serviceInsertedJobPost);
    return createdJobPost;
  } catch (error) {
    throw error;
  }
};

module.exports = {
  getJobPosts,
  createJobPost,
};
