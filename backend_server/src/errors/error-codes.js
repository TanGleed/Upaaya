// This file contains all the error codes and messages

// Import the custom error class
module.exports = {
  INVALID_EMAIL_OR_PASSWORD: {
    statusCode: 400, // Bad Request
    message: "Invalid email address or password",
  },
  USER_NOT_FOUND: {
    statusCode: 404, // Not Found
    message: "User not found",
  },
  INTERNAL_ERROR: {
    statusCode: 500, // Internal Server Error
    message: "Internal Server Error",
  },
  JOB_TITLE_NOT_PROVIDED: {
    statusCode: 400, // Bad Request
    message: "Job title not provided",
  },
  LOCATION_NOT_PROVIDED: {
    statusCode: 400, // Bad Request
    message: "location not provided",
  },
  AT_LEAST_ONE_JOB_TAG_IS_REQUIRED: {
    statusCode: 400, // Bad Request
    message: "at least one job tag is required",
  },
};
