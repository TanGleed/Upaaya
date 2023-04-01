const jobPostsServices = require("../services/jobPosts.services");

const getJobPosts = async (req, res, next) => {
  try {
    const allJobPosts = await jobPostsServices.getJobPosts(req.params);
    res.status(200).send({
      status: "OK",
      data: allJobPosts,
    });
  } catch (error) {
    next(error);
  }
};

const getJobPost = (req, res) => {
  res.status(200).send("Get one workout");
};

const createJobPost = async (req, res, next) => {
  const { body } = req;
  const { params } = req;

  try {
    const createdJobPost = await jobPostsServices.createJobPost(body, params);
    res.status(201).send({
      statusMessage: "JobPost Created",
      data: createdJobPost,
    });
  } catch (error) {
    next(error);
  }
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
