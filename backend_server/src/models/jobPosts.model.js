const mongoose = require("mongoose");

const jobPostSchema = new mongoose.Schema({
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
  //     max: 6,
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

module.exports = mongoose.model("JobPost", jobPostSchema);
