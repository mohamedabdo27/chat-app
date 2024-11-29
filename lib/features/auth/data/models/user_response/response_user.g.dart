// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserResponseAdapter extends TypeAdapter<UserResponse> {
  @override
  final int typeId = 1;

  @override
  UserResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserResponse(
      user: fields[0] as User?,
      token: fields[1] as String?,
      message: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
