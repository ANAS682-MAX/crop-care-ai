import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/scan_result.dart';
import '../providers/app_provider.dart';
import '../services/ai_service.dart';
import '../services/connectivity_service.dart';
import 'result_screen.dart';

class CameraScreen extends StatefulWidget {
  final bool fromGallery;
  const CameraScreen({super.key, this.fromGallery = false});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _image;
  bool _isAnalyzing = false;
  final AIService _aiService = AIService();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _aiService.loadOfflineModel();
    if (widget.fromGallery) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _pickImage());
    }
  }

  Future<void> _pickImage() async {
    final source = widget.fromGallery ? ImageSource.gallery : ImageSource.camera;
    final picked = await _picker.pickImage(source: source, imageQuality: 85);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  Future<void> _analyzeImage() async {
    if (_image == null) return;
    setState(() => _isAnalyzing = true);

    try {
      final isOnline = await ConnectivityService.isOnline();
      Map<String, dynamic> result;

      if (isOnline) {
        result = await _aiService.detectOnline(_image!);
      } else {
        result = await _aiService.detectOffline(_image!);
      }

      // Get location
      double? lat, lng;
      try {
        final permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied) {
          final pos = await Geolocator.getCurrentPosition();
          lat = pos.latitude;
          lng = pos.longitude;
        }
      } catch (_) {}

      final scan = ScanResult(
        id: const Uuid().v4(),
        imagePath: _image!.path,
        diseaseName: result['diseaseName'] ?? 'Unknown',
        confidence: (result['confidence'] ?? 0.0).toDouble(),
        description: result['description'] ?? '',
        treatment: result['treatment'] ?? '',
        scannedAt: DateTime.now(),
        latitude: lat,
        longitude: lng,
        isSynced: isOnline,
      );

      // Save to local history
      final box = Hive.box<ScanResult>('scan_history');
      await box.add(scan);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultScreen(scan: scan, isOnline: isOnline)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Analysis failed: $e')),
      );
    } finally {
      setState(() => _isAnalyzing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scanCrop),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: _image == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_photo_alternate, size: 80, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(l10n.noImageSelected, style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : Image.file(_image!, fit: BoxFit.contain),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                if (_image == null)
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(widget.fromGallery ? Icons.photo_library : Icons.camera_alt),
                    label: Text(widget.fromGallery ? l10n.chooseFromGallery : l10n.takePhoto),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  )
                else ...[
                  ElevatedButton.icon(
                    onPressed: _isAnalyzing ? null : _analyzeImage,
                    icon: _isAnalyzing
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Icon(Icons.search),
                    label: Text(_isAnalyzing ? l10n.analyzing : l10n.analyzeImage),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => setState(() => _image = null),
                    child: Text(l10n.retake),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
