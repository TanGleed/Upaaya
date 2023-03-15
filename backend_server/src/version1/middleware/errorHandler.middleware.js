// Description: This file contains the error handler middleware

// Import the error codes
const errorCodes = require("../../errors/error-codes");

// Create the error handler middleware
function errorHandler(err, req, res, next) {
  const code = (err && err.code) || null;
  const error = errorCodes[code] || errorCodes["INTERNAL_ERROR"];

  // Log the error
  return res.status(error.statusCode).json({ message: error.message });
}

// Export the error handler
module.exports = errorHandler;
