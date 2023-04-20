const JobPost = require("../../models/jobPosts.model");

const getJobs = async () => {
  try {
    const allJobs = await JobPost.find();
    return allJobs;
  } catch (err) {
    throw new Error("Error retrieving job posts");
  }
};

module.exports = {
  getJobs,
};
