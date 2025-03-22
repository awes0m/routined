// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habbits.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabbitAdapter extends TypeAdapter<Habbit> {
  @override
  final int typeId = 1;

  @override
  Habbit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habbit(
      habbitName: fields[0] as String,
      timeSpent: fields[1] as int,
      timeGoal: fields[2] as int,
      habbitStarted: fields[3] == null ? false : fields[3] as bool,
      date: fields[4] == null ? '' : stringToDateTime(fields[4]),
    );
  }

  @override
  void write(BinaryWriter writer, Habbit obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.habbitName)
      ..writeByte(1)
      ..write(obj.timeSpent)
      ..writeByte(2)
      ..write(obj.timeGoal)
      ..writeByte(3)
      ..write(obj.habbitStarted)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabbitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
