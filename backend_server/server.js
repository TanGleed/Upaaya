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
const notifyRouter=require("./src/version1/routes/notify.routes");
// INIT
const PORT = process.env.PORT || 5000;
const hostname = "127.0.0.1";
const app = express();

// Connections
connectDB();

// middleware
app.use(bodyParser.json());
app.use(morgan("dev"));
app.use(express.json());

// Routes
app.use("/api/v1/jobpost", jobPostsRouter);
app.use("/api/v1/auth", authRouter);
app.use("/api/v1/notify",notifyRouter);



// Error handler
app.use(errorHandler);


// npm run server
app.listen(PORT, hostname, () => {
  console.log(`server started on http://${hostname}:${PORT}`);
});
