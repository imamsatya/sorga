// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'ホーム';

  @override
  String get play => 'プレイ';

  @override
  String get achievements => '実績';

  @override
  String get statistics => '統計';

  @override
  String get chooseCategory => 'カテゴリを選択';

  @override
  String levelCompleted(Object id) {
    return 'レベル $id クリア！';
  }

  @override
  String get sortItems => 'アイテムを並べ替え';

  @override
  String get sortNames => '名前を並べ替え';

  @override
  String get lowToHigh => '小 → 大';

  @override
  String get highToLow => '大 → 小';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => '次のレベル';

  @override
  String get retry => 'リトライ';

  @override
  String get dailyChallenge => 'デイリーチャレンジ';

  @override
  String get streak => '連続記録';

  @override
  String get perfect => 'パーフェクト！';

  @override
  String get tryAgain => 'もう一度';

  @override
  String get completed => 'クリア';

  @override
  String get basicNumbers => '基本の数字';

  @override
  String get formattedNumbers => 'フォーマット';

  @override
  String get timeFormats => '時間形式';

  @override
  String get nameSorting => '名前の並べ替え';

  @override
  String get mixedFormats => 'ミックス形式';

  @override
  String get knowledge => 'ナレッジ';

  @override
  String get levels => 'レベル';

  @override
  String get share => 'シェア';

  @override
  String get close => '閉じる';

  @override
  String get yourTime => 'あなたの時間';

  @override
  String get continueGame => '続ける';

  @override
  String get retryLevel => 'レベルをやり直す';
}
