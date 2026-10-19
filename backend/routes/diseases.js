const router = require('express').Router();
const Disease = require('../models/Disease');

// Get all diseases
router.get('/', async (req, res) => {
  try {
    const diseases = await Disease.find();
    res.json(diseases);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Seed sample diseases (dev only)
router.get('/seed', async (req, res) => {
  try {
    await Disease.deleteMany();
    await Disease.insertMany([
      {
        name: 'Tomato Late Blight',
        nameSwahili: 'Ugonjwa wa Nyanya',
        nameAmharic: 'የቲማቲም ዘግይቶ ቅጠል ቁስለት',
        description: 'A serious disease caused by Phytophthora infestans affecting tomatoes and potatoes.',
        causes: 'Caused by the oomycete pathogen Phytophthora infestans.',
        symptoms: 'Dark brown lesions on leaves, white mold on undersides, fruit rot.',
        treatment: 'Apply copper-based fungicides. Remove infected plants immediately.',
        prevention: 'Use resistant varieties, ensure good air circulation, avoid overhead watering.',
        cropType: 'Tomato',
      },
      {
        name: 'Maize Leaf Blight',
        nameSwahili: 'Ugonjwa wa Mahindi',
        nameAmharic: 'የበቆሎ ቅጠል ቁስለት',
        description: 'Northern corn leaf blight caused by Exserohilum turcicum.',
        causes: 'Fungal pathogen Exserohilum turcicum.',
        symptoms: 'Long, elliptical gray-green lesions on leaves.',
        treatment: 'Apply foliar fungicides. Use certified disease-free seeds.',
        prevention: 'Crop rotation, resistant hybrids, proper spacing.',
        cropType: 'Maize',
      },
      {
        name: 'Healthy Plant',
        nameSwahili: 'Mmea Wenye Afya',
        nameAmharic: 'ጤናማ ተክል',
        description: 'No disease detected. Your crop appears healthy.',
        causes: '',
        symptoms: 'No symptoms.',
        treatment: 'Continue good farming practices.',
        prevention: 'Maintain soil health, proper irrigation, and crop rotation.',
        cropType: 'General',
      },
    ]);
    res.json({ message: 'Seeded successfully' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Get disease by id
router.get('/:id', async (req, res) => {
  try {
    const disease = await Disease.findById(req.params.id);
    if (!disease) return res.status(404).json({ message: 'Not found' });
    res.json(disease);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

module.exports = router;
