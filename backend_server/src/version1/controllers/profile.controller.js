const profileServices = require("../services/profile.services");
const addProfile = async (req, res) => {
  try {
    const { name, DOB, contact, address } = req.body;
    const result = await profileServices.addProfile(name, DOB, contact, address);
    return res.json({ msg: result });
  } catch (err) {
    return res.status(400).json({ err: err.message });
  }
};

const updateProfileImage = async (req, res) => {
  try {
    const contact = req.body.contact;
    const imagePath = req.file.path;
    const updated = await profileServices.updateProfileImage(
      contact,
      imagePath
    );
    return res.json({ msg: "Image successfully updated", data: updated});
  } catch (err) {
    return res.status(400).json({ err: err.message });
  }
};

module.exports = {
  addProfile,
  updateProfileImage,
};
