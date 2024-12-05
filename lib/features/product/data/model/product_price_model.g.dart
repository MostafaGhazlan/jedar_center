// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_price_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductPriceModelAdapter extends TypeAdapter<ProductPriceModel> {
  @override
  final int typeId = 6;

  @override
  ProductPriceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductPriceModel(
      id: fields[0] as String?,
      price: fields[1] as double?,
      curr: fields[2] as String?,
      addPrice1: fields[3] as double?,
      curr1: fields[4] as String?,
      addPrice2: fields[5] as double?,
      curr2: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductPriceModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.curr)
      ..writeByte(3)
      ..write(obj.addPrice1)
      ..writeByte(4)
      ..write(obj.curr1)
      ..writeByte(5)
      ..write(obj.addPrice2)
      ..writeByte(6)
      ..write(obj.curr2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductPriceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
