// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameStatsAdapter extends TypeAdapter<GameStats> {
  @override
  final int typeId = 1;

  @override
  GameStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameStats(
      currentStreak: fields[0] as int,
      longestStreak: fields[1] as int,
      lastPlayedDate: fields[2] as DateTime?,
      totalPlayTimeMs: fields[3] as int,
      hasSeenTutorial: fields[4] as bool,
      firstOpenedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, GameStats obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.currentStreak)
      ..writeByte(1)
      ..write(obj.longestStreak)
      ..writeByte(2)
      ..write(obj.lastPlayedDate)
      ..writeByte(3)
      ..write(obj.totalPlayTimeMs)
      ..writeByte(4)
      ..write(obj.hasSeenTutorial)
      ..writeByte(5)
      ..write(obj.firstOpenedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
