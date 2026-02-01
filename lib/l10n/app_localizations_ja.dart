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
  String get knowledge => '知識';

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
  String get currentStreak => '現在の連続日数';

  @override
  String get longestStreak => '最長連続日数';

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
  String get levelsDescription => '11カテゴリ1100レベル。数字、時間、名前などで脳を鍛えよう！';

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

  @override
  String get memorized => '覚えた！';

  @override
  String get memoryMode => '記憶';

  @override
  String get memorizeTime => '記憶';

  @override
  String get sortTime => '並び替え';

  @override
  String get totalTime => '合計時間';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return '$categoryのレベル$levelをクリアして解放';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return '$type$countつを$directionで並べる';
  }

  @override
  String get ascending => '昇順';

  @override
  String get descending => '降順';

  @override
  String get multiplayer => 'マルチプレイヤー';

  @override
  String get multiplayerSetup => 'マルチプレイヤー設定';

  @override
  String get selectCategory => 'カテゴリ選択';

  @override
  String get itemCount => 'アイテム数';

  @override
  String get playerCount => 'プレイヤー数';

  @override
  String playerName(Object number) {
    return 'プレイヤー$number名';
  }

  @override
  String get startGame => 'ゲーム開始';

  @override
  String getReadyPlayer(Object name) {
    return '$nameさん、準備！';
  }

  @override
  String get yourTurn => 'あなたの番です！';

  @override
  String get tapToStart => 'タップして開始';

  @override
  String get giveUp => 'ギブアップ';

  @override
  String get failed => '失敗';

  @override
  String get failedNextPlayer => '失敗！次へ...';

  @override
  String continueLeft(Object count) {
    return '続ける ($count回残り)';
  }

  @override
  String get draw => '引き分け！';

  @override
  String get everyoneGaveUp => '全員がギブアップ！';

  @override
  String get everyoneFailed => '全員が失敗！';

  @override
  String get noOneCompleted => '誰も完了しなかった！';

  @override
  String get leaderboard => 'リーダーボード';

  @override
  String get localMultiplayer => 'ローカルマルチプレイヤー';

  @override
  String get players => 'プレイヤー';

  @override
  String get addPlayer => 'プレイヤー追加';

  @override
  String get removePlayer => '削除';

  @override
  String get category => 'カテゴリ';

  @override
  String get ready => '準備？';

  @override
  String get go => 'GO!';

  @override
  String get complete => '完了';

  @override
  String get unlocked => '解除済み';

  @override
  String get locked => '未解除';

  @override
  String get secretAchievement => 'シークレット実績';

  @override
  String get dailyChallenges => 'デイリーチャレンジ';

  @override
  String get dailyCompleted => '完了数';

  @override
  String get perfectCompletions => 'パーフェクト';

  @override
  String get multiplayerGames => 'マルチプレイ';

  @override
  String get memoryProgress => 'メモリー進捗';

  @override
  String get achFirstSteps => 'はじめの一歩';

  @override
  String get achFirstStepsDesc => '最初のレベルをクリア';

  @override
  String get achGettingStarted => 'スタート';

  @override
  String get achGettingStartedDesc => '10レベルをクリア';

  @override
  String get achOnARoll => '絶好調';

  @override
  String get achOnARollDesc => '50レベルをクリア';

  @override
  String get achCenturyClub => '100クラブ';

  @override
  String get achCenturyClubDesc => '100レベルをクリア';

  @override
  String get achHalfwayThere => '折り返し地点';

  @override
  String get achHalfwayThereDesc => '500レベルをクリア';

  @override
  String get achSortingMaster => 'ソートマスター';

  @override
  String get achSortingMasterDesc => '全600レベルをクリア';

  @override
  String get achConsistent => '継続は力';

  @override
  String get achConsistentDesc => '3日連続プレイ';

  @override
  String get achWeekWarrior => '週間戦士';

  @override
  String get achWeekWarriorDesc => '7日連続プレイ';

  @override
  String get achMonthlyMaster => '月間マスター';

  @override
  String get achMonthlyMasterDesc => '30日連続プレイ';

  @override
  String get achLegendaryStreak => '伝説の連続記録';

  @override
  String get achLegendaryStreakDesc => '100日連続プレイ';

  @override
  String get achSpeedDemon => 'スピードの悪魔';

  @override
  String get achSpeedDemonDesc => '5秒以内にクリア';

  @override
  String get achLightningFast => '電光石火';

  @override
  String get achLightningFastDesc => '3秒以内にクリア';

  @override
  String get achBasicExpert => '基本のエキスパート';

  @override
  String get achBasicExpertDesc => '基本100レベル';

  @override
  String get achFormatPro => 'フォーマットプロ';

  @override
  String get achFormatProDesc => '形式100レベル';

  @override
  String get achTimeLord => 'タイムロード';

  @override
  String get achTimeLordDesc => '時間100レベル';

  @override
  String get achAlphabetizer => '名前の達人';

  @override
  String get achAlphabetizerDesc => '名前100レベル';

  @override
  String get achMixMaster => 'ミックスマスター';

  @override
  String get achMixMasterDesc => '混合100レベル';

  @override
  String get achKnowledgeKing => '知識の王';

  @override
  String get achKnowledgeKingDesc => '知識100レベル';

  @override
  String get achBasicPerfectionist => '基本パーフェクト';

  @override
  String get achBasicPerfectionistDesc => '基本100%完了';

  @override
  String get achFormatPerfectionist => '形式パーフェクト';

  @override
  String get achFormatPerfectionistDesc => '形式100%完了';

  @override
  String get achTimePerfectionist => '時間パーフェクト';

  @override
  String get achTimePerfectionistDesc => '時間100%完了';

  @override
  String get achNamesPerfectionist => '名前パーフェクト';

  @override
  String get achNamesPerfectionistDesc => '名前100%完了';

  @override
  String get achMixedPerfectionist => '混合パーフェクト';

  @override
  String get achMixedPerfectionistDesc => '混合100%完了';

  @override
  String get achKnowledgePerfectionist => '知識パーフェクト';

  @override
  String get achKnowledgePerfectionistDesc => '知識100%完了';

  @override
  String get achMemoryNovice => 'メモリー初心者';

  @override
  String get achMemoryNoviceDesc => 'メモリー10レベル';

  @override
  String get achMemoryExpert => 'メモリーエキスパート';

  @override
  String get achMemoryExpertDesc => 'メモリー50レベル';

  @override
  String get achMemoryMaster => 'メモリーマスター';

  @override
  String get achMemoryMasterDesc => 'メモリー100レベル';

  @override
  String get achPerfectRecall => '完璧な記憶';

  @override
  String get achPerfectRecallDesc => 'メモリー5回ノーミス';

  @override
  String get achMemoryPro => 'メモリープロ';

  @override
  String get achMemoryProDesc => 'メモリー10回ノーミス';

  @override
  String get achMemoryGenius => 'メモリー天才';

  @override
  String get achMemoryGeniusDesc => 'メモリー25回ノーミス';

  @override
  String get achEideticMemory => '映像記憶';

  @override
  String get achEideticMemoryDesc => 'メモリー50回ノーミス';

  @override
  String get achPhotographicMemory => '写真記憶';

  @override
  String get achPhotographicMemoryDesc => 'メモリー100回ノーミス';

  @override
  String get achMemoryBasicMaster => 'メモリー基本マスター';

  @override
  String get achMemoryBasicMasterDesc => 'メモリーで基本全完了';

  @override
  String get achMemoryFormatMaster => 'メモリー形式マスター';

  @override
  String get achMemoryFormatMasterDesc => 'メモリーで形式全完了';

  @override
  String get achMemoryTimeMaster => 'メモリー時間マスター';

  @override
  String get achMemoryTimeMasterDesc => 'メモリーで時間全完了';

  @override
  String get achMemoryNamesMaster => 'メモリー名前マスター';

  @override
  String get achMemoryNamesMasterDesc => 'メモリーで名前全完了';

  @override
  String get achMemoryMixedMaster => 'メモリー混合マスター';

  @override
  String get achMemoryMixedMasterDesc => 'メモリーで混合全完了';

  @override
  String get achDailyStarter => 'デイリースタート';

  @override
  String get achDailyStarterDesc => '初のデイリー';

  @override
  String get achWeeklyChallenger => '週間挑戦者';

  @override
  String get achWeeklyChallengerDesc => 'デイリー7回';

  @override
  String get achMonthlyChallenger => '月間挑戦者';

  @override
  String get achMonthlyChallengerDesc => 'デイリー30回';

  @override
  String get achDailyLegend => 'デイリーレジェンド';

  @override
  String get achDailyLegendDesc => 'デイリー100回';

  @override
  String get achPerfectDay => 'パーフェクトデイ';

  @override
  String get achPerfectDayDesc => 'デイリー5回ノーミス';

  @override
  String get achPerfectWeek => 'パーフェクトウィーク';

  @override
  String get achPerfectWeekDesc => 'デイリー10回ノーミス';

  @override
  String get achPerfectStreak => 'パーフェクト連続';

  @override
  String get achPerfectStreakDesc => 'デイリー25回ノーミス';

  @override
  String get achFlawlessPlayer => '完璧なプレイヤー';

  @override
  String get achFlawlessPlayerDesc => 'デイリー50回ノーミス';

  @override
  String get achDailyPerfectionist => 'デイリー完璧主義';

  @override
  String get achDailyPerfectionistDesc => 'デイリー100回ノーミス';

  @override
  String get achPartyHost => 'パーティホスト';

  @override
  String get achPartyHostDesc => 'マルチ10ゲーム';

  @override
  String get achSocialGamer => 'ソーシャルゲーマー';

  @override
  String get achSocialGamerDesc => 'マルチ25ゲーム';

  @override
  String get achMultiplayerLegend => 'マルチレジェンド';

  @override
  String get achMultiplayerLegendDesc => 'マルチ50ゲーム';

  @override
  String get achPerfectRun => 'パーフェクトラン';

  @override
  String get achPerfectRunDesc => '10レベル連続ノーミス';

  @override
  String get achDedicatedPlayer => '熱心なプレイヤー';

  @override
  String get achDedicatedPlayerDesc => '累計1時間プレイ';

  @override
  String get achMarathonRunner => 'マラソンランナー';

  @override
  String get achMarathonRunnerDesc => '累計5時間プレイ';

  @override
  String get achTotalMaster => 'トータルマスター';

  @override
  String get achTotalMasterDesc => '1100レベル達成';

  @override
  String get achCompletionist => 'コンプリート';

  @override
  String get achCompletionistDesc => '全実績を解除';

  @override
  String get achNightOwl => '夜型人間';

  @override
  String get achNightOwlDesc => '深夜0時〜5時にプレイ';

  @override
  String get achEarlyBird => '早起き鳥';

  @override
  String get achEarlyBirdDesc => '朝5時〜7時にプレイ';

  @override
  String get achNewYearSorter => '新年ソーター';

  @override
  String get achNewYearSorterDesc => '1月1日にプレイ';

  @override
  String get achNeverGiveUp => '諦めない心';

  @override
  String get achNeverGiveUpDesc => 'リトライ50回使用';

  @override
  String get achInstantWin => '即勝利';

  @override
  String get achInstantWinDesc => '2秒以内にクリア';

  @override
  String get achDescendingFan => '降順ファン';

  @override
  String get achDescendingFanDesc => '降順20連続';

  @override
  String get achSwapMaster => 'スワップマスター';

  @override
  String get achSwapMasterDesc => 'スワップのみで10レベル';

  @override
  String get achShiftMaster => 'シフトマスター';

  @override
  String get achShiftMasterDesc => 'シフトのみで10レベル';

  @override
  String get watchAd => 'Watch Ad for Extra Chance';

  @override
  String get goPro => 'Go Pro - Unlimited Mistakes';
}
