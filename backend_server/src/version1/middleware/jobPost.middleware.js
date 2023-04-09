const multer = require("multer");
const storage = multer.diskStorage({
  destination: process.env.UPLOADS_DIR || "./uploads/jobPosts",
  filename: function (req, file, cb) {
    cb(null, Date.now() + "-" + file.originalname);
  },
});
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 10, // 10MB max file size
  },
  fileFilter: function (req, file, cb) {
    if (
      !file.originalname.match(/\.(jpg|jpeg|png|gif|bmp|mp4|avi|mkv|mov)$/i)
    ) {
      return cb(new Error("Invalid file type"));
    }
    cb(null, true);
  },
});

const handleUpload = (req, res, next) => {
  upload.array("media", 3)(req, res, (err) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Error uploading files" });
    }
    next();
  });
};

module.exports = handleUpload;
