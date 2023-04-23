// Import the mongoose package
const mongoose = require("mongoose");

// Define the options for the schema
const schemaOptions = {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true },
};

// Create the job post schema
const jobPostSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
      trim: true,
    },
    location: {
      type: String,
      required: true,
      index: true,
      trim: true,
    },
    description: {
      type: String,
      required: true,
      trim: true,
    },
    media: [
      {
        type: String,
      },
    ],

    tags: [
      {
        type: String,
        required: true,
      },
    ],
    additionalInfo: {
      type: String,
    },
  },
  schemaOptions
);

// Add a virtual that returns the number of media files associated with a job post
jobPostSchema.virtual("mediaCount").get(function () {
  return this.media.length;
});

// Export the job post model
module.exports = mongoose.model("JobPost", jobPostSchema);
