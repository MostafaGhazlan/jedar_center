// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discount_tem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiscountIIemModelAdapter extends TypeAdapter<DiscountIIemModel> {
  @override
  final int typeId = 3;

  @override
  DiscountIIemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiscountIIemModel(
      id: fields[1] as int?,
      productId: fields[2] as String?,
      sDiscountId: fields[3] as int?,
      discount: fields[4] as DiscountModel?,
    )
      ..discountType = fields[5] as int?
      ..discountValue = fields[6] as int?;
  }

  @override
  void write(BinaryWriter writer, DiscountIIemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.sDiscountId)
      ..writeByte(4)
      ..write(obj.discount)
      ..writeByte(5)
      ..write(obj.discountType)
      ..writeByte(6)
      ..write(obj.discountValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiscountIIemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
