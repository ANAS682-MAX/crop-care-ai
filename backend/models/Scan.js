const mongoose = require('mongoose');

const scanSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  diseaseName: { type: String, required: true },
  confidence: { type: Number, required: true },
  description: String,
  treatment: String,
  causes: String,
  imageUrl: String,
  location: {
    latitude: Number,
    longitude: Number,
  },
  scannedAt: { type: Date, default: Date.now },
}, { timestamps: true });

module.exports = mongoose.model('Scan', scanSchema);
