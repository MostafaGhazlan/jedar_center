// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixModelAdapter extends TypeAdapter<MatrixModel> {
  @override
  final int typeId = 0;

  @override
  MatrixModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixModel(
      id: fields[0] as int?,
      matrixName: fields[1] as String?,
      matrixNameEn: fields[2] as String?,
      imageName: fields[3] as String?,
      categoryId: fields[4] as String?,
      matrixTypeId: fields[5] as int?,
      notes: fields[6] as String?,
      info: fields[7] as String?,
      productCount: fields[8] as int?,
      products: (fields[9] as List?)?.cast<ProductModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MatrixModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.matrixName)
      ..writeByte(2)
      ..write(obj.matrixNameEn)
      ..writeByte(3)
      ..write(obj.imageName)
      ..writeByte(4)
      ..write(obj.categoryId)
      ..writeByte(5)
      ..write(obj.matrixTypeId)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.info)
      ..writeByte(8)
      ..write(obj.productCount)
      ..writeByte(9)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
