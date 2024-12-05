// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandModelAdapter extends TypeAdapter<BrandModel> {
  @override
  final int typeId = 10;

  @override
  BrandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandModel(
      id: fields[0] as String?,
      brandName: fields[1] as String?,
      colorName: fields[2] as String?,
      colorCode: fields[3] as String?,
      description: fields[4] as String?,
      document: (fields[5] as List?)?.cast<DocumentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, BrandModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brandName)
      ..writeByte(2)
      ..write(obj.colorName)
      ..writeByte(3)
      ..write(obj.colorCode)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.document);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
