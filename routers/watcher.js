const express = require("express");
const watcherRouter = express.Router();
const watcher = require("../middlewares/watcher");
const User = require("../models/users");

//GET ALL PATIENT
watcherRouter.get("/watcher/get-all-patient", async (req, res) => {
  try {
    const patient = await User.find({ watcherId: req.query.watcherId });
    res.json(patient);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
// DELETE PATIENT
watcherRouter.post("/watcher/delete-patient", async (req, res) => {
  try {
    let user = await User.findOneAndDelete({ _id: req.query.userId });
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = watcherRouter;
