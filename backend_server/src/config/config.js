const mongoose = require("mongoose");
const { connect } = mongoose;

const connectDB = async () => {
  try {
    const conn = await connect(process.env.MONGO_URI);

    console.log(`MongoDB Connected: ${conn.connection.host}`.cyan.underline);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

module.exports = connectDB;
