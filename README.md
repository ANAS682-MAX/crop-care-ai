# CropCare - AI Crop Disease Detection

Mobile app for East African farmers to detect crop diseases using AI.

## Project Structure

```
crop_disease_app/   Flutter mobile app
backend/            Node.js + Express + MongoDB API
```

## Setup

### Flutter App
1. Install Flutter: https://flutter.dev/docs/get-started/install
2. cd crop_disease_app
3. flutter pub get
4. Add your Plant.id API key in lib/services/ai_service.dart
5. flutter run

### Backend
1. Install Node.js and MongoDB
2. cd backend
3. npm install
4. Update .env with your MongoDB URI and JWT secret
5. npm run dev

### Get Plant.id API Key
1. Register at https://web.plant.id
2. Go to your dashboard and copy your API key
3. Paste it in lib/services/ai_service.dart
4. Free tier gives you 100 identifications/day — enough to get started

### TFLite Offline Model
Place a crop_disease_model.tflite file in crop_disease_app/assets/models/
Download from Kaggle or train using PlantVillage dataset.
