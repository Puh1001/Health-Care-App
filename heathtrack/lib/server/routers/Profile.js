const express = require("express");
const profileRouter = express.Router();
const patient = require("../middlewares/patientProfile");
const Profile = require("../models/Profile");
// ADD PATIENT
profileRouter.post("/api/add-profile", async (req, res) => {
  try {
    const {
      dateOfBirth,
      gender,
      phoneNumber,
      bloodType,
      image,
      height,
      weight,
      userId,
    } = req.body;
    let profile = new Profile({
      dateOfBirth,
      gender,
      phoneNumber,
      image,
      bloodType,
      height,
      weight,
      userId,
    });
    profile = await profile.save();
    res.json(profile);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET PROFILE USER
profileRouter.get("/api/get-profile", async (req, res) => {
  try {
    const profile = await Profile.find({ userId: req.query.userId });
    res.json(profile);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
module.exports = profileRouter;
