// Description: This file contains all the business logic for the jobPosts API

// Import the jobPosts data
const jobPostsData = require("../database/jobPosts.data");
// Import the custom error
const CustomError = require("../../errors/custom-error");
// Import the jobPost model
const JobPost = require("../../models/jobPosts.model");

// Create the getJobPosts function
const getJobPosts = async () => {
  try {
    // try to get all the jobPosts
    const allJobPosts = await jobPostsData.getJobPosts(); // get all the jobPosts
    return allJobPosts; // return the jobPosts
  } catch (err) {
    // catch any errors
    next(err);
  }
};

// Create the getJobPost function
const getJobPost = async (params) => {
  try {
    // try to get a single jobPost
    const singleJobPost = await jobPostsData.getJobPost(params); // get a single jobPost
    return singleJobPost; // return the jobPost
  } catch (err) {
    // catch any errors
    next(err);
  }
};

// Create the createJobPost function
const createJobPost = async ({
  title,
  location,
  description,
  media,
  tags,
  additionalInfo,
}) => {
  // Validate title, location, and tags
  if (!title) {
    throw new CustomError("JOB_TITLE_NOT_PROVIDED");
  }

  if (!location) {
    throw new CustomError("LOCATION_NOT_PROVIDED");
  }

  if (!Array.isArray(tags)) {
    throw new CustomError("AT_LEAST_ONE_JOB_TAG_IS_REQUIRED");
  }

  // Create a new jobPost
  const newJobPost = new JobPost({
    title,
    location,
    description,
    media,
    tags,
    additionalInfo,
  });

  try {
    // try to save the jobPost
    const createdJobPost = await newJobPost.save(); // save the jobPost
    return createdJobPost;
  } catch (error) {
    // catch any errors
    console.log(error);
    throw new Error("JOB_POST_CREATION_FAILED");
  }
};

// Create the updateJobPost function
const updateJobPost = async (body, params) => {
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
    // try to update the jobPost
    const updatedJobPost = await jobPostsData.updateJobPost(newJobPost, params); // update the jobPost
    return updatedJobPost;
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// Create the deleteJobPost function
const deleteJobPost = async (params) => {
  try {
    // try to delete the jobPost
    const deletedJobPost = await jobPostsData.deleteJobPost(params); // delete the jobPost
    return deletedJobPost;
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// Export the functions
module.exports = {
  getJobPosts,
  getJobPost,
  createJobPost,
  updateJobPost,
  deleteJobPost,
};
