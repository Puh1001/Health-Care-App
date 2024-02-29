const express = require("express");
const paitientRouter = express.Router();
const watcher = require("../middlewares/watcher");
// ADD PATIENT
watcherRouter.post("/watcher/add-patient", watcher, async (res, req) => {
  try {
    const { name, email, password, type } = req.body;
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});
