const express = require("express");
const heathDataRouter = express.Router();
const HeathData = require("../models/heathData");
const auth = require("../middlewares/auth");

// SAVE DATA
heathDataRouter.post("/api/heath-data", async (req, res) => {
  try {
    const { heartRate, spb, dbp, oxygen, temperature, glucose, step, userId } =
      req.body;
    let heathData = new HeathData({
      heartRate,
      spb,
      dbp,
      oxygen,
      temperature,
      glucose,
      step,
      userId,
    });
    heathData = await heathData.save();
    res.json(heathData);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET ALL DATA (modified)
heathDataRouter.get("/api/get-heath-data", async (req, res) => {
  try {
    const userID = req.user; // Lấy userID từ middleware auth
    // const heathData = await HeathData.find({ userID });
    const heathData = await HeathData.find({});
    res.json(heathData);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = heathDataRouter;
