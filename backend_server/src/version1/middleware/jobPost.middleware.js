
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