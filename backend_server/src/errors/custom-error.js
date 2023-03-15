// Description: Custom error class

// Import the error codes
class CustomError extends Error {
  constructor(code) {
    super();
    this.code = code;
  }
}

// Export the custom error
module.exports = CustomError;
