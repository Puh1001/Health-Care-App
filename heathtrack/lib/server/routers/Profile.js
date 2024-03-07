const express = require("express");
const profileRouter = express.Router();
const patient = require("../middlewares/patientProfile");
const Profile = require("../models/Profile");
// ADD PATIENT
profileRouter.post("/api/add-profile", async (req, res) => {
  try {
    const {
      name,
      dateOfBirth,
      gender,
      phoneNumber,
      image,
      email,
      height,
      weight,
      userId,
    } = req.body;
    let profile = new Profile({
      name,
      dateOfBirth,
      gender,
      phoneNumber,
      image,
      email,
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
