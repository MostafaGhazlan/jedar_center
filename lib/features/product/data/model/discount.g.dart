// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscountModelAdapter extends TypeAdapter<DiscountModel> {
  @override
  final int typeId = 4;

  @override
  DiscountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiscountModel(
      id: fields[1] as int?,
      discountName: fields[2] as String?,
      discountCode: fields[3] as String?,
      discountType: fields[4] as int?,
      discountValue: fields[5] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, DiscountModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.discountName)
      ..writeByte(3)
      ..write(obj.discountCode)
      ..writeByte(4)
      ..write(obj.discountType)
      ..writeByte(5)
      ..write(obj.discountValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
