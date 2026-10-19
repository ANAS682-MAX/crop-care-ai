import 'dart:io';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/scan_result.dart';

class ResultScreen extends StatelessWidget {
  final ScanResult scan;
  final bool isOnline;

  const ResultScreen({super.key, required this.scan, required this.isOnline});

  Color get _confidenceColor {
    if (scan.confidence >= 0.8) return Colors.green;
    if (scan.confidence >= 0.5) return Colors.orange;
    return Colors.red;
  }

  bool get _isHealthy => scan.diseaseName.toLowerCase().contains('healthy');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.results),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(scan.imagePath),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Status badge
            if (!isOnline)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.wifi_off, size: 14, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(l10n.offlineMode, style: const TextStyle(color: Colors.orange, fontSize: 12)),
                  ],
                ),
              ),

            const SizedBox(height: 12),

            // Disease name
            Row(
              children: [
                Icon(_isHealthy ? Icons.check_circle : Icons.warning, color: _isHealthy ? Colors.green : Colors.red, size: 28),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    scan.diseaseName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Confidence
            Row(
              children: [
                Text(l10n.confidence, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: _confidenceColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(scan.confidence * 100).toStringAsFixed(1)}%',
                    style: TextStyle(color: _confidenceColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const Divider(height: 32),

            if (scan.description.isNotEmpty) ...[
              _SectionTitle(l10n.description),
              Text(scan.description),
              const SizedBox(height: 16),
            ],

            if (scan.treatment.isNotEmpty) ...[
              _SectionTitle(l10n.treatment),
              Text(scan.treatment),
              const SizedBox(height: 16),
            ],

            if (scan.latitude != null) ...[
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    '${scan.latitude!.toStringAsFixed(4)}, ${scan.longitude!.toStringAsFixed(4)}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              icon: const Icon(Icons.home),
              label: Text(l10n.backToHome),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
    );
  }
}
