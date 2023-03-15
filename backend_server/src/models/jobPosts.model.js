// Description: This file contains the schema for the job posts collection in the database

// Import the mongoose package
const mongoose = require("mongoose");

// Create the job post schema
const jobPostSchema = new mongoose.Schema({
  // create the schema
  title: {
    type: String,
    required: true,
  },
  location: {
    type: String,
    required: true,
  },
  description: {
    type: String,
  },
  // media: [
  //   {
  //     type: String,
  //   },
  // ],
  tags: [
    {
      type: String,
      required: true,
    },
  ],
  additionalInfo: {
    type: String,
  },
});

// Export the job post model
module.exports = mongoose.model("JobPost", jobPostSchema);
