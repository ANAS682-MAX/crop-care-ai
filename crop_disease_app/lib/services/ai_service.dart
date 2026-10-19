import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

extension _StringFallback on String {
  String ifEmpty(String fallback) => isEmpty ? fallback : this;
}

class AIService {
  static const String _plantIdApiKey = 'YOUR_PLANT_ID_API_KEY';
  static const String _plantIdUrl = 'https://api.plant.id/v2/health_assessment';
  List<String> _labels = [];

  Future<void> loadOfflineModel() async {
    if (kIsWeb) return;
    try {
      final labelsData = await rootBundle.loadString('assets/labels/labels.txt');
      _labels = labelsData.split('\n').where((l) => l.isNotEmpty).toList();
    } catch (_) {}
  }

  Future<Map<String, dynamic>> detectOnline(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    final response = await http.post(
      Uri.parse(_plantIdUrl),
      headers: {'Content-Type': 'application/json', 'Api-Key': _plantIdApiKey},
      body: jsonEncode({'images': [base64Image], 'modifiers': ['crops_fast'], 'disease_details': ['description', 'treatment', 'cause'], 'language': 'en'}),
    );
    if (response.statusCode == 200) return _parseResult(jsonDecode(response.body));
    throw Exception('Plant.id detection failed: ${response.statusCode}');
  }

  Map<String, dynamic> _parseResult(Map<String, dynamic> data) {
    final health = data['health_assessment'];
    if (health != null && health['is_healthy'] == true) {
      return {'diseaseName': 'Healthy Plant', 'confidence': (health['is_healthy_probability'] ?? 1.0).toDouble(), 'description': 'Your crop appears healthy.', 'causes': '', 'symptoms': '', 'treatment': 'Continue good farming practices.', 'prevention': 'Maintain soil health.'};
    }
    final diseases = health?['diseases'] as List?;
    if (diseases == null || diseases.isEmpty) {
      return {'diseaseName': 'Unknown', 'confidence': 0.0, 'description': 'Could not identify.', 'causes': '', 'symptoms': '', 'treatment': 'Consult your local agronomist.', 'prevention': ''};
    }
    final top = diseases.first;
    final details = top['disease_details'] ?? {};
    return {'diseaseName': top['name'] ?? 'Unknown Disease', 'confidence': (top['probability'] ?? 0.0).toDouble(), 'description': details['description'] ?? '', 'causes': details['cause'] ?? '', 'symptoms': '', 'treatment': 'Consult your local agronomist.', 'prevention': ''};
  }

  Future<Map<String, dynamic>> detectOffline(File imageFile) async {
    return {'diseaseName': 'Unknown', 'confidence': 0.0, 'description': 'Offline unavailable.', 'treatment': 'Consult agronomist.', 'causes': '', 'symptoms': ''};
  }

  void dispose() {}
}
