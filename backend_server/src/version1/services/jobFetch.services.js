const Job = require('../../models/jobFetch.model');

async function getAllJobs() {
  try {
    return await Job.find();
  } catch (error) {
    throw error;
  }
}

module.exports = {
  getAllJobs,
};