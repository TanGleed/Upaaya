// @AjushRG
// @2023-16-03
// @Description: This file contains all the controllers for the jobPosts

const jobPostsServices = require("../services/jobPosts.services");
const JobPost = require("../../models/jobPosts.model");
const uploadMiddleware = require("../middleware/jobPost.middleware");

// @desc: Get all jobPosts
// @route: GET /api/v1/jobPosts
// @access: Public
const getJobPosts = async (req, res, next) => {
  try {
    // try to get all the jobPosts
    const allJobPosts = await jobPostsServices.getJobPosts();
    res.status(200).send({
      // send the response
      status: "OK",
      data: allJobPosts,
    });
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// @desc: Get a single jobPost
// @route: GET /api/v1/jobPosts/:id
// @access: Public
const getJobPost = async (req, res, next) => {
  try {
    // try to get a single jobPost
    const singleJobPost = await jobPostsServices.getJobPost(req.params);
    res.status(200).send({
      // send the response
      status: "OK",
      data: singleJobPost,
    });
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// @desc: Create a jobPost
// @route: POST /api/v1/jobPosts
// @access: Private
// Controller function for handling job post creation
const createJobPost = (req, res) => {
  try {
    uploadMiddleware(req, res, async (err) => {
      if (err) {
        throw new Error(err.message);
      } else {
        const { title, location, description, tags, additionalInfo } = req.body;

        const media = req.files.map((file) => file.filename);

        const jobPost = await JobPost.create({
          title,
          location,
          description,
          media,
          tags,
          additionalInfo,
        });

        res.status(201).json({ jobPost });
      }
    });
  } catch (error) {
    console.log(error);
    res.status(400).json({ message: error.message });
  }
};

// @desc: Update a jobPost
// @route: PUT /api/v1/jobPosts/:id
// @access: Private
const updateJobPost = (req, res) => {
  const { body } = req; // get the body of the request
  const { params } = req; // get the params of the request

  try {
    // try to update a jobPost
    const updatedJobPost = jobPostsServices.updateJobPost(body, params);
    res.status(200).send({
      statusMessage: "JobPost Updated",
      data: updatedJobPost,
    });
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// @desc: Delete a jobPost
// @route: DELETE /api/v1/jobPosts/:id
// @access: Private
const deleteJobPost = (req, res) => {
  const { params } = req; // get the params of the request

  try {
    // try to delete a jobPost
    const deletedJobPost = jobPostsServices.deleteJobPost(params);
    res.status(200).send({
      statusMessage: "JobPost Deleted",
      data: deletedJobPost,
    });
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// export all the controllers
module.exports = {
  getJobPosts,
  getJobPost,
  createJobPost,
  updateJobPost,
  deleteJobPost,
};
