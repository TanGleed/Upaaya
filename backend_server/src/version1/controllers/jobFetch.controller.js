const jobService = require('../services/jobFetch.services');

async function getAllJobs(req, res, next) {
    try {
      const jobs = await jobService.getAllJobs();
      res.status(200).json(jobs);
    } catch (error) {
      next(error);
    }
  }
  
  module.exports = {
    getAllJobs,
  };