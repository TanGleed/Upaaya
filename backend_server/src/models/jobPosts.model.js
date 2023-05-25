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
        required: true,
      },
    ],

    tags: {
      type: String,
      required: true,
    },

    latitude: {
      type: String,
      required: true,
    },
    longitude:
    {
      type: String,
      required: true,
    },
    additionalInfo: {
      type: String,
    },
    clientemail:
    {
      type: String,
      trim: true,
      match:
        /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/,
    },
    jobStatus:
    {
      type: String,
      trim: true,
    }
  },
  schemaOptions
);

// Add a virtual that returns the number of media files associated with a job post
jobPostSchema.virtual("mediaCount").get(function () {
  return this.media.length;
});

// Export the job post model
module.exports = mongoose.model("JobPost", jobPostSchema);
