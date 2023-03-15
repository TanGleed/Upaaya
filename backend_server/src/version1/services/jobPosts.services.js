const jobPostsData = require("../database/jobPosts.data");
const CustomError = require("../../errors/custom-error");
const JobPost = require("../../models/jobPosts.model");

const getJobPosts = async (params) => {
  try {
    const allJobPosts = await jobPostsData.getJobPosts(params);
    return allJobPosts;
  } catch (err) {
    next(err);
  }
};

const createJobPost = async (body, params) => {
  const { title, location, description, tags, additionalInfo } = body;

  if (!title) {
    throw new CustomError("JOB_TITLE_NOT_PROVIDED");
  }

  if (!location) {
    throw new CustomError("LOCATION_NOT_PROVIDED");
  }

  if (!tags) {
    throw new CustomError("AT_LEAST_ONE_JOB_TAG_IS_REQUIRED");
  }

  const newJobPost = new JobPost({
    title,
    location,
    description,
    tags,
    additionalInfo,
  });

  try {
    const createdJobPost = await newJobPost.save();
    return createdJobPost;
  } catch (error) {
    next(error);
  }
};

module.exports = {
  getJobPosts,
  createJobPost,
};
