// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_bus_stop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedBusStopModelAdapter extends TypeAdapter<SavedBusStopModel> {
  @override
  final int typeId = 1;

  @override
  SavedBusStopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedBusStopModel(
      id: fields[0] as int?,
      userBusStopName: fields[1] as String?,
      realBusStopName: fields[2] as String?,
      destinations: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SavedBusStopModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userBusStopName)
      ..writeByte(2)
      ..write(obj.realBusStopName)
      ..writeByte(3)
      ..write(obj.destinations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedBusStopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
