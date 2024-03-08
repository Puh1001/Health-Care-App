const mongoose = require("mongoose");
const User = require("./users");

const profileSchema = mongoose.Schema({
  name: {
    type: String,
    require: true,
    trim: true,
  },
  dateOfBirth: {
    type: Date,
    requite: true,
    trim: true,
  },
  gender: {
    type: String,
    require: true,
    trim: true,
  },
  phoneNumber: {
    type: String,
    require: true,
    trim: true,
  },
  image: {
    type: String,
    require: true,
  },
  email: {
    type: String,
    require: true,
    trim: true,
  },
  height: {
    type: Number,
    require: true,
    trim: true,
  },
  weight: {
    type: Number,
    require: true,
    trim: true,
  },
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    require: true,
    ref: "User",
  },
});

const Profile = mongoose.model("Profile", profileSchema);
module.exports = Profile;