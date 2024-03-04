const express = require("express");
const heathDataRouter = express.Router();
const HeathData = require("../models/heathData");

// GET DATA
heathDataRouter.post("/api/heath-data", async (req, res) => {
  try {
    const { heartRate, spb, dbp, oxygen, temperature, glucose, step } =
      req.body;
    let heathData = new HeathData({
      heartRate,
      spb,
      dbp,
      oxygen,
      temperature,
      glucose,
      step,
    });
    heathData = await heathData.save();
    res.json(heathData);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = heathDataRouter;
