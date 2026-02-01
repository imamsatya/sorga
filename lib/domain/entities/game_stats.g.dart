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
      consecutivePerfect: fields[6] as int,
      memoryPerfectCount: fields[7] as int,
      dailyPerfectCount: fields[8] as int,
      dailyCompletions: fields[9] as int,
      multiplayerGamesHosted: fields[10] as int,
      retryCount: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GameStats obj) {
    writer
      ..writeByte(12)
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
      ..write(obj.firstOpenedAt)
      ..writeByte(6)
      ..write(obj.consecutivePerfect)
      ..writeByte(7)
      ..write(obj.memoryPerfectCount)
      ..writeByte(8)
      ..write(obj.dailyPerfectCount)
      ..writeByte(9)
      ..write(obj.dailyCompletions)
      ..writeByte(10)
      ..write(obj.multiplayerGamesHosted)
      ..writeByte(11)
      ..write(obj.retryCount);
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
