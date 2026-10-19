import 'package:hive/hive.dart';

part 'scan_result.g.dart';

@HiveType(typeId: 0)
class ScanResult extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final String diseaseName;

  @HiveField(3)
  final double confidence;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final String treatment;

  @HiveField(6)
  final DateTime scannedAt;

  @HiveField(7)
  final double? latitude;

  @HiveField(8)
  final double? longitude;

  @HiveField(9)
  final bool isSynced;

  ScanResult({
    required this.id,
    required this.imagePath,
    required this.diseaseName,
    required this.confidence,
    required this.description,
    required this.treatment,
    required this.scannedAt,
    this.latitude,
    this.longitude,
    this.isSynced = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'diseaseName': diseaseName,
        'confidence': confidence,
        'description': description,
        'treatment': treatment,
        'scannedAt': scannedAt.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
      };
}
