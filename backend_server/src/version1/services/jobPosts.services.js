// Description: This file contains all the business logic for the jobPosts API

// Import the jobPosts data
const jobPostsData = require("../database/jobPosts.data");
// Import the custom error
const CustomError = require("../../errors/custom-error");
// Import the jobPost model
const JobPost = require("../../models/jobPosts.model");

// Create the getJobPosts function
const getJobPosts = async (params) => {
  try {
    // try to get all the jobPosts
    const allJobPosts = await jobPostsData.getJobPosts(params); // get all the jobPosts
    return allJobPosts; // return the jobPosts
  } catch (err) {
    // catch any errors
    next(err);
  }
};

// Create the createJobPost function
const createJobPost = async (body, params) => {
  const { title, location, description, tags, additionalInfo } = body; // destructure the body

  // Validate title, location, and tags
  if (!title) {
    throw new CustomError("JOB_TITLE_NOT_PROVIDED");
  }

  if (!location) {
    throw new CustomError("LOCATION_NOT_PROVIDED");
  }

  if (!tags) {
    throw new CustomError("AT_LEAST_ONE_JOB_TAG_IS_REQUIRED");
  }

  // Create a new jobPost
  const newJobPost = new JobPost({
    title,
    location,
    description,
    tags,
    additionalInfo,
  });

  try {
    // try to save the jobPost
    const createdJobPost = await jobPostsData.createJobPost(newJobPost, params); // save the jobPost
    return createdJobPost;
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// Export the functions
module.exports = {
  getJobPosts,
  createJobPost,
};
