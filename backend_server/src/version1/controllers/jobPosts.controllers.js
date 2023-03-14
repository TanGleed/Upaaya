const jobPostsServices = require("../services/jobPosts.services");
const JobPostModel = require("../../models/jobPosts.model");
const mongoose = require("mongoose");

const getJobPosts = async (req, res) => {
  const allJobPosts = await jobPostsServices.getJobPosts(req.params);

  res.status(200).send({
    status: "OK",
    data: allJobPosts,
  });
};

const getJobPost = (req, res) => {
  res.status(200).send("Get one workout");
};

const createJobPost = async (req, res) => {
  const { body } = req;

  if (!body.title || !body.location || !body.tags) {
    res.status(400).send({
      status: "FAILED",
      data: {
        error:
          "One of the following keys is missing or is empty in request body: 'title', 'location' and 'tags'",
      },
    });
    return;
  }

  const newJobPost = new JobPostModel({
    title: body.title,
    location: body.location,
    description: body.description,
    tags: body.tags,
    additionalInfo: body.additionalInfo,
  });

  const createdJobPost = await newJobPost.save();
  res.status(201).json({
    status: "OK",
    message: "New JonPost Created",
    data: createdJobPost,
  });
};

const updateJobPost = (req, res) => {
  res.status(200).send("update a existing workout");
};

const deleteJobPost = (req, res) => {
  res.status(200).send("Get a existing workout");
};

module.exports = {
  getJobPosts,
  getJobPost,
  createJobPost,
  updateJobPost,
  deleteJobPost,
};
