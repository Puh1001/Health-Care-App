const express = require("express");
const User = require("../models/users");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

// REGISTER
authRouter.post("/api/register", async (req, res) => {
  try {
    const { name, email, password, familyCode, type, watcherId, age } =
      req.body;
    if (type !== "patient") {
      typeWatcher = "watcher";
    }
    if (name === "" || email === "" || password === "" || familyCode == "") {
      return res.status(400).json({ msg: "Do not empty text field!!" });
    }
    const existingUser = await User.findOne({
      email,
    });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "User with same email already exists!" });
    }
    const existingFamilyCode = await User.findOne({
      familyCode,
      type: "watcher",
    });
    if (existingFamilyCode) {
      return res
        .status(400)
        .json({ msg: "User with same family code already exists!" });
    }

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      email,
      password: hashedPassword,
      name,
      familyCode,
      type: typeWatcher,
      watcherId,
      age,
    });

    user = await user.save();
    res.json(user);
  } catch (err) {
    res.json({ msg: "Internal server error" });
  }
});

// LOGIN

authRouter.post("/api/login", async (req, res) => {
  try {
    const { email, password, familyCode } = req.body;

    if (email === "" || password === "" || familyCode === "") {
      return res.status(400).json({ msg: "Do not empty text field!!" });
    }
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ msg: "User with this email does not exist!!" });
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ msg: "Incorrect password!!" });
    }
    const fCode = await User.findOne({ familyCode });
    if (!fCode) {
      return res
        .status(400)
        .json({ msg: "Family code with this email wrong!!" });
    }

    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// TOKEN IS VALID
authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.status(200).json(false);
    }

    let verified;
    try {
      verified = jwt.verify(token, "passwordKey");
    } catch (e) {
      return res.status(200).json(false);
    }

    if (!verified) {
      return res.status(200).json(false);
    }

    const user = await User.findById(verified.id);
    if (!user) {
      return res.status(200).json(false);
    }

    return res.status(200).json(true);
  } catch (err) {
    res.status(500).json({ msg: "Internal server error" });
  }
});

// GET USER DATA

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
