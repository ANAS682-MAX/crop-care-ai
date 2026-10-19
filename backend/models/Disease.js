const mongoose = require('mongoose');

const diseaseSchema = new mongoose.Schema({
  name: { type: String, required: true },
  nameSwahili: String,
  nameAmharic: String,
  description: String,
  descriptionSwahili: String,
  descriptionAmharic: String,
  causes: String,
  symptoms: String,
  treatment: String,
  prevention: String,
  imageUrl: String,
  cropType: String,
}, { timestamps: true });

module.exports = mongoose.model('Disease', diseaseSchema);
