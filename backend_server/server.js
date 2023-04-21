// Description: This is the main file of the backend server. It is the entry point of the server.

// IMPORTS FROM PACKAGES
const express = require("express");
const colors = require("colors");
const morgan = require("morgan");
const bodyParser = require("body-parser");
const dotenv = require("dotenv").config();

// IMPORTS FROM OTHER FILES
const connectDB = require("./src/config/config");
const errorHandler = require("./src/version1/middleware/errorHandler.middleware");
const jobPostsRouter = require("./src/version1/routes/jobPosts.routes");
const authRouter = require("./src/version1/routes/auth.routes");
const notifyRouter = require("./src/version1/routes/notify.routes");
const homepageRouter = require("./src/version1/routes/category.routes");
const jobRoutes = require("./src/version1/routes/jobFetch.routes");

// INIT
const PORT = process.env.PORT || 7000;
const hostname = "172.20.10.6";
const app = express();

// Connections
connectDB();

// middleware
app.use(bodyParser.json());
app.use(morgan("dev"));
app.use(express.json());
app.use("/uploads", express.static("uploads"));

// Routes
app.use("/api/v1/jobpost", jobPostsRouter);
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/notify", notifyRouter);
app.use("/api/v1/category", homepageRouter);
app.use("/api/v1/jobs", jobRoutes);

// Error handler
app.use(errorHandler);

// npm run server
app.listen(PORT, hostname, () => {
  console.log(`server started on http://${hostname}:${PORT}`);
});
