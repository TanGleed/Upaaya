// Import the mongoose package
const mongoose = require("mongoose");

// Define the options for the schema
const schemaOptions = {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true },
  versionKey: false,
};

// Create the job post schema
const jobPostSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    location: {
      type: String,
      required: true,
      index: true,
    },
    description: {
      type: String,
      required: true,
    },
    media: {
      type: [
        {
          type: String,
          validate: {
            validator: function (value) {
              return /\.(jpg|jpeg|png|gif|bmp|mp4|avi|mkv|mov)$/i.test(value);
            },
            message: "Invalid media file type",
          },
        },
      ],
    },
    tags: {
      type: [
        {
          type: String,
          required: true,
        },
      ],
    },
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
