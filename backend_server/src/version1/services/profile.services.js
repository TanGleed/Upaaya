
const {Profile} = require("../../models/profile.model");

const addProfile = async (name, DOB, contact, address) => {
  const profile = Profile({
    name: name,
    DOB: DOB,
    contact: contact,
    address: address
  });
  try {
    await profile.save();
    return "Profile successfully stored";
  } catch (err) {
    throw new Error(err.message);
  }
};

const updateProfileImage = async (contact, imagePath) => {
  try {
    const updated = await Profile.findOneAndUpdate(
      { contact: contact },
      { $set: { img: imagePath } },
      { new: true }
    );
    return updated;
  } catch (err) {
    throw new Error(err.message);
  }
};
module.exports = {
  addProfile,
  updateProfileImage,
};
