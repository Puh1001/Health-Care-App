const express = require("express");
const paitientRouter = express.Router();
const patient = require("../middlewares/patientProfile");
const PatientProfile = require("../models/patientProfile");
// ADD PATIENT
paitientRouter.post(
  "/patient/add-patient-profile",
  patient,
  async (res, req) => {
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
        bmi,
      } = req.body;
      let patientProfile = new PatientProfile({
        name,
        dateOfBirth,
        gender,
        phoneNumber,
        image,
        email,
        height,
        weight,
        bmi,
      });
      patientProfile = await patientProfile.save();
      res.json(patientProfile);
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
);
