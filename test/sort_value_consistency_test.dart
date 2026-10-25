import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:sortiq/domain/entities/level.dart';
import 'package:sortiq/domain/entities/level_item.dart';
import 'package:sortiq/levels/daily_challenge_generator.dart';
import 'package:sortiq/levels/level_generator.dart';
import 'package:sortiq/presentation/providers/multiplayer_provider.dart';

/// Verifies that the order a player can SEE (displayValue) always agrees with
/// the order the game ACCEPTS (sortValue). Otherwise a visually correct answer
/// can be rejected.
void main() {
  final playable = LevelCategory.values.where((c) => c != LevelCategory.knowledge);

  group('Display order matches sortValue', () {
    final generator = LevelGenerator();

    for (final category in playable) {
      test('regular ${category.name} levels', () {
        generator.getLevelsByCategory(category).forEach(_expectConsistent);
      });

      test('memory ${category.name} levels', () {
        generator.getMemoryLevelsByCategory(category).forEach(_expectConsistent);
      });

      test('multiplayer ${category.name} sessions', () {
        final notifier = MultiplayerNotifier();
        for (var itemCount = 3; itemCount <= 30; itemCount++) {
          for (var k = 0; k < 20; k++) {
            _expectConsistent(notifier.generateCustomLevel(
              category: category,
              itemCount: itemCount,
              isMemoryMode: false,
              sessionId: '${1760000000000 + itemCount * 1000 + k}',
            ));
          }
        }
      });
    }

    test('daily challenges for two years', () {
      final daily = DailyChallengeGenerator();
      final start = DateTime(2026, 1, 1);
      for (var i = 0; i < 730; i++) {
        _expectConsistent(daily.generateChallengeForDate(start.add(Duration(days: i))));
      }
    });
  });
}

void _expectConsistent(Level level) {
  final items = level.items;
  for (var i = 0; i < items.length; i++) {
    for (var j = i + 1; j < items.length; j++) {
      final a = items[i], b = items[j];
      final shown = _compareDisplay(a, b, level.category);
      final accepted = a.sortValue.compareTo(b.sortValue);
      expect(shown, accepted,
          reason: '${level.category.name} level ${level.id}: '
              '"${a.displayValue}" vs "${b.displayValue}" '
              '(sortValue ${a.sortValue} vs ${b.sortValue})');
    }
  }
}

int _compareDisplay(LevelItem a, LevelItem b, LevelCategory category) {
  if (category == LevelCategory.names) {
    return a.displayValue.toLowerCase().compareTo(b.displayValue.toLowerCase()).sign;
  }
  final diff = _parseDisplay(a.displayValue) - _parseDisplay(b.displayValue);
  if (diff.abs() < 1e-9) return 0;
  return diff.sign.toInt();
}

const _superscripts = '⁰¹²³⁴⁵⁶⁷⁸⁹';
const _timeUnits = {'sec': 1, 'min': 60, 'hr': 3600, 'days': 86400};

/// Parses a displayed value into the number a player would read from it
double _parseDisplay(String display) {
  final unit = RegExp(r'^([\d.]+) (sec|min|hr|days)$').firstMatch(display);
  if (unit != null) {
    return double.parse(unit.group(1)!) * _timeUnits[unit.group(2)]!;
  }

  final hoursMinutes = RegExp(r'^(\d+)h (\d+)m$').firstMatch(display);
  if (hoursMinutes != null) {
    return int.parse(hoursMinutes.group(1)!) * 3600.0 + int.parse(hoursMinutes.group(2)!) * 60;
  }

  final minutesSeconds = RegExp(r'^(\d+)m (\d+)s$').firstMatch(display);
  if (minutesSeconds != null) {
    return int.parse(minutesSeconds.group(1)!) * 60.0 + int.parse(minutesSeconds.group(2)!);
  }

  final secondsOnly = RegExp(r'^(\d+)s$').firstMatch(display);
  if (secondsOnly != null) return double.parse(secondsOnly.group(1)!);

  if (display.endsWith('%')) {
    return double.parse(display.substring(0, display.length - 1)) / 100;
  }

  if (display.contains('/')) {
    final parts = display.split('/');
    return double.parse(parts[0]) / double.parse(parts[1]);
  }

  final power = RegExp('^(\\d+)([$_superscripts]+)\$').firstMatch(display);
  if (power != null) {
    final exponent = power.group(2)!.split('').map(_superscripts.indexOf).join();
    return pow(double.parse(power.group(1)!), int.parse(exponent)).toDouble();
  }

  return double.parse(display.replaceAll(',', ''));
}
