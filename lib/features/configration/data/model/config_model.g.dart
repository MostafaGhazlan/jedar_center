// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrentUserModelAdapter extends TypeAdapter<CurrentUserModel> {
  @override
  final int typeId = 5;

  @override
  CurrentUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrentUserModel(
      id: fields[0] as String?,
      tenantId: fields[1] as String?,
      name: fields[2] as String?,
      surname: fields[3] as String?,
      userName: fields[4] as String?,
      email: fields[5] as String?,
      phoneNumber: fields[6] as String?,
      mobile: fields[7] as String?,
      address: fields[8] as String?,
      secondAddress: fields[9] as String?,
      latitude: fields[10] as String?,
      longitude: fields[11] as String?,
      isAuthenticated: fields[12] as bool?,
      concurrencyStamp: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentUserModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.surname)
      ..writeByte(4)
      ..write(obj.userName)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.phoneNumber)
      ..writeByte(7)
      ..write(obj.mobile)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.secondAddress)
      ..writeByte(10)
      ..write(obj.latitude)
      ..writeByte(11)
      ..write(obj.longitude)
      ..writeByte(12)
      ..write(obj.isAuthenticated)
      ..writeByte(13)
      ..write(obj.concurrencyStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
