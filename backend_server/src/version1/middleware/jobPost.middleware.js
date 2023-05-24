// const multer = require("multer");

// // Set storage engine for multer
// const storage = multer.diskStorage({
//   destination: (req, file, cb) => {
//     cb(null, "uploads/jobPosts");
//   },
//   filename: (req, file, cb) => {
//     cb(null, file.originalname);
//   },
// });

// // Filter for accepted file types
// const fileFilter = (req, file, cb) => {
//   if (
//     file.mimetype === "image/jpeg" ||
//     file.mimetype === "image/jpg" ||
//     file.mimetype === "image/png" ||
//     file.mimetype === "image/gif" ||
//     file.mimetype === "video/mp4"
//   ) {
//     cb(null, true);
//   } else {
//     cb(new Error("Invalid file type"), false);
//   }
// };

// // Set upload middleware
// const upload = multer({
//   storage: storage,
//   limits: {
//     fileSize: 1024 * 1024 * 10, // 10 MB
//   },
//   fileFilter: fileFilter,
// }).array("media");

// const uploadMiddleware = (req, res, next) => {
//   upload(req, res, (err) => {
//     if (err) {
//       res.status(400).send({
//         status: "ERROR",
//         message: err.message,
//       });
//     }
//     if (!req.files || req.files.length === 0) {
//       return res.status(400).json({
//         error: "Please select at least one file to upload",
//       });
//     }
//     next();
//   });
// };

// // Export the upload middleware

// module.exports = uploadMiddleware;
const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
  destination: "./uploads/jobPosts",
  filename: (req, file, callback) => {
    callback(null,Date.now() + "-" + file.originalname);
  },
});

const fileFilter = (req, file, callback) => {
  const acceptableExt = [".png", ".jpg", ".jpeg"];
  if (!acceptableExt.includes(path.extname(file.originalname))) {
    return callback(new Error("Only .png, .jpg and .jpeg format allowed!"));
  }
  
  const fileSize = parseInt(req.headers["content-length"]);

  if (fileSize > 10485760) {
    return callback(new Error("File Size Big"));
  }

  callback(null, true);
};

let upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  fileSize: 10485760,
});

module.exports = upload.array('media',10);