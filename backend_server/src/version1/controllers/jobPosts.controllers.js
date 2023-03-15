// @AjushRG
// @2023-16-03
// @Description: This file contains all the controllers for the jobPosts

const jobPostsServices = require("../services/jobPosts.services");

// @desc: Get all jobPosts
// @route: GET /api/v1/jobPosts
// @access: Public
const getJobPosts = async (req, res, next) => {
  try {
    // try to get all the jobPosts
    const allJobPosts = await jobPostsServices.getJobPosts(req.params);
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
const getJobPost = (req, res) => {
  res.status(200).send("Get one workout");
};

// @desc: Create a jobPost
// @route: POST /api/v1/jobPosts
// @access: Private
const createJobPost = async (req, res, next) => {
  const { body } = req; // get the body of the request
  const { params } = req; // get the params of the request

  try {
    // try to create a jobPost
    const createdJobPost = await jobPostsServices.createJobPost(body, params);
    res.status(201).send({
      statusMessage: "JobPost Created",
      data: createdJobPost,
    });
  } catch (error) {
    // catch any errors
    next(error);
  }
};

// @desc: Update a jobPost
// @route: PUT /api/v1/jobPosts/:id
// @access: Private
const updateJobPost = (req, res) => {
  res.status(200).send("update a existing workout");
};

// @desc: Delete a jobPost
// @route: DELETE /api/v1/jobPosts/:id
// @access: Private
const deleteJobPost = (req, res) => {
  res.status(200).send("Get a existing workout");
};

// export all the controllers
module.exports = {
  getJobPosts,
  getJobPost,
  createJobPost,
  updateJobPost,
  deleteJobPost,
};
