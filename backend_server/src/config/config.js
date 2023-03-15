// Description: This file contains the configuration for the server

// Import the dotenv package
const mongoose = require("mongoose");

// Connect to the database
const { connect } = mongoose;

// Create the connection function
const connectDB = async () => {
  try {
    // try to connect to the database
    const conn = await connect(process.env.MONGO_URI);

    // Log the connection
    console.log(`MongoDB Connected: ${conn.connection.host}`.cyan.underline);
  } catch (error) {
    // catch any errors
    console.log(error);
    process.exit(1); // exit the process with failure
  }
};

// Export the connection function
module.exports = connectDB;
