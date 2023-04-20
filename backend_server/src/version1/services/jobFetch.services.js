const JobFetchData = require("../database/jobFetch.data");

async function getAllJobs() {
  try {
    const allJobs = await JobFetchData.getJobs();
    return allJobs;
  } catch (error) {
    throw error;
  }
}

module.exports = {
  getAllJobs,
};
