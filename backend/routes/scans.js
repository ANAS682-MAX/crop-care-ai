const router = require('express').Router();
const multer = require('multer');
const path = require('path');
const Scan = require('../models/Scan');
const auth = require('../middleware/auth');

const storage = multer.diskStorage({
  destination: 'uploads/',
  filename: (_, file, cb) => cb(null, `${Date.now()}${path.extname(file.originalname)}`),
});
const upload = multer({ storage });

// Save a scan
router.post('/', auth, upload.single('image'), async (req, res) => {
  try {
    const data = JSON.parse(req.body.data);
    const scan = await Scan.create({
      user: req.user.id,
      diseaseName: data.diseaseName,
      confidence: data.confidence,
      description: data.description,
      treatment: data.treatment,
      causes: data.causes,
      imageUrl: req.file ? `/uploads/${req.file.filename}` : null,
      location: { latitude: data.latitude, longitude: data.longitude },
      scannedAt: data.scannedAt,
    });
    res.status(201).json(scan);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Get user scans
router.get('/', auth, async (req, res) => {
  try {
    const scans = await Scan.find({ user: req.user.id }).sort({ scannedAt: -1 });
    res.json(scans);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Delete a scan
router.delete('/:id', auth, async (req, res) => {
  try {
    await Scan.findOneAndDelete({ _id: req.params.id, user: req.user.id });
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
