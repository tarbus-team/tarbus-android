// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribed_version_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscribedVersionModelAdapter
    extends TypeAdapter<SubscribedVersionModel> {
  @override
  final int typeId = 0;

  @override
  SubscribedVersionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscribedVersionModel(
      subscribeCode: fields[0] as String?,
      updateDate: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SubscribedVersionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.subscribeCode)
      ..writeByte(1)
      ..write(obj.updateDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscribedVersionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
