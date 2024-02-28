const mongoose = require("mongoose");

const patientSchema = mongoose.Schema({
  name: {
    type: String,
    require: true,
    trim: true,
  },
  email: {
    type: String,
    requite: true,
    trim: true,
  },
});

const Patient = mongoose.model("Patient", patientSchema);
module.exports = Patient;
