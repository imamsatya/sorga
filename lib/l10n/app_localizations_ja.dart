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

  @override
  String get yourSortingParadise => 'あなたのソートパラダイス';

  @override
  String get done => '完了';

  @override
  String get progress => '進捗';

  @override
  String get time => '時間';

  @override
  String get day => '日';

  @override
  String get days => '日';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get systemDefault => 'システムデフォルト';

  @override
  String get soundEffects => '効果音';

  @override
  String get vibration => 'バイブレーション';

  @override
  String get check => 'チェック';

  @override
  String get level => 'レベル';

  @override
  String get items => 'アイテム';

  @override
  String get sortAscending => '昇順';

  @override
  String get sortDescending => '降順';

  @override
  String get best => 'ベスト';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return '$count個の$typeを$directionに並べ替え';
  }

  @override
  String get playAgain => 'もう一度プレイ';

  @override
  String get startChallenge => 'チャレンジ開始';

  @override
  String get completedToday => '今日完了！';

  @override
  String get comeBackTomorrow => '明日新しいチャレンジに戻ってきてください';

  @override
  String get shareResult => '結果をシェア';

  @override
  String get shareAchievement => '実績をシェア';

  @override
  String get canYouBeatMyTime => '私のタイムを超えられますか？';

  @override
  String get dailyStreak => 'デイリーストリーク';

  @override
  String get dailyStreakActive => 'デイリーストリーク進行中！';

  @override
  String get categoryProgress => 'カテゴリ進捗';

  @override
  String get completedLevels => '完了レベル';

  @override
  String get currentStreak => '現在の連続記録';

  @override
  String get longestStreak => '最長連続記録';

  @override
  String get totalPlayTime => '合計プレイ時間';

  @override
  String get totalAttempts => '合計試行回数';

  @override
  String get achievementsTitle => '実績';

  @override
  String get statisticsTitle => '統計';

  @override
  String get selectLevel => 'レベルを選択';

  @override
  String get about => 'アプリについて';

  @override
  String get appDescription => 'Sorga - ソートゲーム';

  @override
  String get version => 'バージョン';

  @override
  String get levelsDescription => '6カテゴリ800レベル。数字、時間、名前などで脳を鍛えよう！';

  @override
  String get dragAndDrop => 'ドラッグ＆ドロップ';

  @override
  String get dragItemsDescription => 'アイテムをドラッグして正しい順序に並べ替えてください';

  @override
  String get skip => 'スキップ';

  @override
  String get next => '次へ';

  @override
  String get shift => 'シフト';

  @override
  String get swap => 'スワップ';

  @override
  String get reset => 'リセット';

  @override
  String get daily => 'デイリー';

  @override
  String get orderNotRight => '順序が正しくありません。';

  @override
  String chancesLeft(Object count) {
    return '残り$count回のチャンスがあります！';
  }

  @override
  String get sort => 'ソート';

  @override
  String get asc => '昇順';

  @override
  String get desc => '降順';

  @override
  String get thursday => '木曜日';

  @override
  String get friday => '金曜日';

  @override
  String get saturday => '土曜日';

  @override
  String get sunday => '日曜日';

  @override
  String get monday => '月曜日';

  @override
  String get tuesday => '火曜日';

  @override
  String get wednesday => '水曜日';

  @override
  String get getReady => '準備はいい？';

  @override
  String get attempt => '試行';

  @override
  String get noMoreChances => 'チャンスがなくなりました。もう一度！';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y クリア';
  }

  @override
  String get sortTheItems => 'アイテムを並べ替える';

  @override
  String get tapCheckWhenDone => '完了したらチェックをタップ。';

  @override
  String get useDragMode => 'シフトまたはスワップモードを使用';

  @override
  String get shiftModeDescription => 'シフトモードはアイテムをスライド。スワップモードは位置を交換。';

  @override
  String get youreReady => '準備完了！';

  @override
  String get startSorting => 'ソートを開始して自己ベストを更新しよう！';

  @override
  String get bestTime => 'ベストタイム';

  @override
  String get attempts => '試行回数';

  @override
  String get iCompletedLevel => 'Sorgaでこのレベルをクリアしました！私の記録を破れるかな？';

  @override
  String get dailyChallengeShare => '🎯 Sorga デイリーチャレンジ';

  @override
  String get shiftAndSwap => 'シフト & スワップ';

  @override
  String get shiftAndSwapDescription => 'シフトモードで段階的に移動、またはスワップで位置を交換';

  @override
  String get checkAnswer => '回答を確認';

  @override
  String get checkAnswerDescription => '準備ができたら、チェックをタップして回答を確認。頑張って！';

  @override
  String get startPlaying => 'プレイ開始';

  @override
  String get january => '1月';

  @override
  String get february => '2月';

  @override
  String get march => '3月';

  @override
  String get april => '4月';

  @override
  String get may => '5月';

  @override
  String get june => '6月';

  @override
  String get july => '7月';

  @override
  String get august => '8月';

  @override
  String get september => '9月';

  @override
  String get october => '10月';

  @override
  String get november => '11月';

  @override
  String get december => '12月';

  @override
  String get numbers => '数字';

  @override
  String get times => '時刻';

  @override
  String get names => '名前';
}
