// Description: This is the main file of the backend server. It is the entry point of the server.

// IMPORTS FROM PACKAGES
const express = require("express");
const colors = require("colors");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const cors = require("cors");
const dotenv = require("dotenv").config();

// IMPORTS FROM OTHER FILES
const connectDB = require("./src/config/config");
const errorHandler = require("./src/version1/middleware/errorHandler.middleware");
const jobPostsRouter = require("./src/version1/routes/jobPosts.routes");
const authRouter = require("./src/version1/routes/auth.routes");
const notifyRouter = require("./src/version1/routes/notify.routes");
const homepageRouter = require("./src/version1/routes/category.routes");
const jobRoutes = require("./src/version1/routes/jobFetch.routes");
const profileRoutes = require("./src/version1/routes/profile.routes");
const { uploadimage } = require("./src/version1/controllers/profile.controller");

// INIT
const PORT = process.env.PORT || 4000;
const hostname = "127.0.0.1";
const app = express();

// Connections
connectDB();

// middleware
app.use(express.json());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(morgan("dev"));
app.use("/uploads",express.static("uploads"));

// Routes
app.use("/api/v1/jobpost", jobPostsRouter);
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/notify", notifyRouter);
app.use("/api/v1/category", homepageRouter);
app.use("/api/v1/jobs", jobRoutes);
app.use("/api/v1/profile",profileRoutes);

// Error handler
app.use(errorHandler);

// npm run server
app.listen(PORT, hostname, () => {
  console.log(`server started on http://${hostname}:${PORT}`);
});
