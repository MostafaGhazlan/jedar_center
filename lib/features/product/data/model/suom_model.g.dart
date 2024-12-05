// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suom_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SUoMModelAdapter extends TypeAdapter<SUoMModel> {
  @override
  final int typeId = 7;

  @override
  SUoMModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SUoMModel(
      id: fields[0] as int?,
      unitSymbole: fields[1] as String?,
      unitName: fields[2] as String?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SUoMModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.unitSymbole)
      ..writeByte(2)
      ..write(obj.unitName)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SUoMModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
