// IMPORTS FROM PACKAGES
const express = require("express");
const mongoose = require("mongoose");
const colors = require("colors");
const dotenv = require("dotenv").config();

// IMPORTS FROM OTHER FILES
const { errorHandler } = require("./middleware/errorMiddleware");
const connectDB = require("./config/database");

// INIT
const PORT = process.env.PORT || 5000;
const hostname = "192.168.1.68";
const app = express();

// Connections
connectDB();

// middleware
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(errorHandler);

// Routes

// npm run server
app.listen(PORT, hostname, () => {
  console.log(`server started on http://${hostname}:${PORT}`);
});
