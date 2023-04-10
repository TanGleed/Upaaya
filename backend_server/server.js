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
<<<<<<< HEAD
const notifyRouter=require("./src/version1/routes/notify.routes");
=======
const homepageRouter= require("./src/version1/routes/category.routes");
const jobRoutes = require('./src/version1/routes/jobFetch.routes');

>>>>>>> 8f4a6a9bfef43b52efacaa4a43f6128eb5004ea2
// INIT
const PORT = process.env.PORT || 5000;
const hostname = "127.0.0.1";
;
const app = express();

// Connections
connectDB();

// middleware
app.use(bodyParser.json());
app.use(morgan("dev"));
<<<<<<< HEAD
app.use(express.json());
=======
app.use("src/version1/uploads",express.static("uploads"));
>>>>>>> 8f4a6a9bfef43b52efacaa4a43f6128eb5004ea2

// Routes
app.use("/api/v1/jobpost", jobPostsRouter);
app.use("/api/v1/auth", authRouter);
<<<<<<< HEAD
app.use("/api/v1/notify",notifyRouter);


=======
app.use("/api/v1/category",homepageRouter );
app.use('/api/v1/jobs', jobRoutes);
>>>>>>> 8f4a6a9bfef43b52efacaa4a43f6128eb5004ea2

// Error handler
app.use(errorHandler);


// npm run server
app.listen(PORT, hostname, () => {
  console.log(`server started on http://${hostname}:${PORT}`);
});
