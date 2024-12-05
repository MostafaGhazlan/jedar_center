// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 8;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      id: fields[0] as String?,
      categoryCode: fields[1] as String?,
      categoryName: fields[2] as String?,
      parentId: fields[3] as String?,
      description: fields[4] as String?,
      documents: (fields[7] as List?)?.cast<DocumentModel>(),
      children: (fields[5] as List?)?.cast<Children>(),
      concurrencyStamp: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryCode)
      ..writeByte(2)
      ..write(obj.categoryName)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.children)
      ..writeByte(6)
      ..write(obj.concurrencyStamp)
      ..writeByte(7)
      ..write(obj.documents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChildrenAdapter extends TypeAdapter<Children> {
  @override
  final int typeId = 9;

  @override
  Children read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Children(
      id: fields[0] as String?,
      categoryCode: fields[1] as String?,
      categoryName: fields[2] as String?,
      parentId: fields[3] as String?,
      description: fields[4] as String?,
      children: (fields[5] as List?)?.cast<Children>(),
      documents: (fields[7] as List?)?.cast<DocumentModel>(),
      concurrencyStamp: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Children obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryCode)
      ..writeByte(2)
      ..write(obj.categoryName)
      ..writeByte(3)
      ..write(obj.parentId)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.children)
      ..writeByte(6)
      ..write(obj.concurrencyStamp)
      ..writeByte(7)
      ..write(obj.documents);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChildrenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
