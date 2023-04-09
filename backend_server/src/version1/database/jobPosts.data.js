// Description: This file contains the database functions for the jobPosts model

// Import the jobPost model
const JobPost = require("../../models/jobPosts.model");

// Create the getJobPosts function
const getJobPosts = async () => {
  try {
    const allJobPosts = await JobPost.find();
    return allJobPosts;
  } catch (err) {
    throw new Error("Error retrieving job posts");
  }
};

// Create the getJobPost function
const getJobPost = async (params) => {
  try {
    const jobPost = await JobPost.findById(params.id);
    if (!jobPost) {
      throw new Error("Job post not found");
    }
    return jobPost;
  } catch (err) {
    throw new Error("Error retrieving job post");
  }
};

// Create the createJobPost function
const createJobPost = async (jobPostData) => {
  try {
    const createdJobPost = await jobPostData.save();
    return createdJobPost;
  } catch (err) {
    throw new Error("Error creating job post");
  }
};

// Create the updateJobPost function
const updateJobPost = async (jobPostData, params) => {
  const { title, location, description, tags, additionalInfo } = jobPostData;

  if (!title || !location || !tags) {
    throw new Error("Missing required fields");
  }

  try {
    const jobPost = await JobPost.findById(params.id);
    if (!jobPost) {
      throw new Error("Job post not found");
    }

    jobPost.title = title;
    jobPost.location = location;
    jobPost.description = description;
    jobPost.tags = tags;
    jobPost.additionalInfo = additionalInfo;

    const updatedJobPost = await jobPost.save();
    return updatedJobPost;
  } catch (err) {
    throw new Error("Error updating job post");
  }
};

// Create the deleteJobPost function
const deleteJobPost = async (params) => {
  try {
    const deletedJobPost = await JobPost.findByIdAndDelete(params.id);
    if (!deletedJobPost) {
      throw new Error("Job post not found");
    }
    return deletedJobPost;
  } catch (err) {
    throw new Error("Error deleting job post");
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
