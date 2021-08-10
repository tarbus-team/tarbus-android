// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_bus_line_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedBusLineModelAdapter extends TypeAdapter<SavedBusLineModel> {
  @override
  final int typeId = 2;

  @override
  SavedBusLineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedBusLineModel(
      id: fields[0] as int?,
      realLineName: fields[1] as String?,
      realCompanyName: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedBusLineModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.realLineName)
      ..writeByte(2)
      ..write(obj.realCompanyName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedBusLineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
