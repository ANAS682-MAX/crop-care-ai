// GENERATED CODE - DO NOT MODIFY BY HAND
// Run: flutter pub run build_runner build

part of 'scan_result.dart';

class ScanResultAdapter extends TypeAdapter<ScanResult> {
  @override
  final int typeId = 0;

  @override
  ScanResult read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScanResult(
      id: fields[0] as String,
      imagePath: fields[1] as String,
      diseaseName: fields[2] as String,
      confidence: fields[3] as double,
      description: fields[4] as String,
      treatment: fields[5] as String,
      scannedAt: fields[6] as DateTime,
      latitude: fields[7] as double?,
      longitude: fields[8] as double?,
      isSynced: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ScanResult obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath)
      ..writeByte(2)
      ..write(obj.diseaseName)
      ..writeByte(3)
      ..write(obj.confidence)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.treatment)
      ..writeByte(6)
      ..write(obj.scannedAt)
      ..writeByte(7)
      ..write(obj.latitude)
      ..writeByte(8)
      ..write(obj.longitude)
      ..writeByte(9)
      ..write(obj.isSynced);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ScanResultAdapter && runtimeType == other.runtimeType && typeId == other.typeId;

  @override
  int get hashCode => typeId.hashCode;
}
