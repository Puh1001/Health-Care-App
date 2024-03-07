const express = require("express");
const watcherRouter = express.Router();
const watcher = require("../middlewares/watcher");
const User = require("../models/users");

//GET ALL PATIENT
watcherRouter.get("/watcher/get-all-patient", async (req, res) => {
  try {
    console.log(req.query.address);
    const patient = await User.find({ address: req.query.address });
    res.json(patient);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = watcherRouter;
