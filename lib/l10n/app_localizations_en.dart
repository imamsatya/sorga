// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Home';

  @override
  String get play => 'Play';

  @override
  String get achievements => 'Achievements';

  @override
  String get statistics => 'Statistics';

  @override
  String get chooseCategory => 'Choose Category';

  @override
  String levelCompleted(Object id) {
    return 'Level $id Completed!';
  }

  @override
  String get sortItems => 'Sort Items';

  @override
  String get sortNames => 'Sort Names';

  @override
  String get lowToHigh => 'Low → High';

  @override
  String get highToLow => 'High → Low';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Next Level';

  @override
  String get retry => 'Retry';

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get streak => 'Streak';

  @override
  String get perfect => 'PERFECT!';

  @override
  String get tryAgain => 'TRY AGAIN';

  @override
  String get completed => 'completed';

  @override
  String get basicNumbers => 'Basic Numbers';

  @override
  String get formattedNumbers => 'Formatted';

  @override
  String get timeFormats => 'Time Formats';

  @override
  String get nameSorting => 'Name Sorting';

  @override
  String get mixedFormats => 'Mixed Formats';

  @override
  String get knowledge => 'Knowledge';

  @override
  String get levels => 'levels';

  @override
  String get share => 'Share';

  @override
  String get close => 'Close';

  @override
  String get yourTime => 'YOUR TIME';

  @override
  String get continueGame => 'CONTINUE';

  @override
  String get retryLevel => 'RETRY LEVEL';

  @override
  String get yourSortingParadise => 'Your Sorting Paradise';

  @override
  String get done => 'Done';

  @override
  String get progress => 'Progress';

  @override
  String get time => 'Time';

  @override
  String get day => 'day';

  @override
  String get days => 'days';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System Default';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get vibration => 'Vibration';

  @override
  String get check => 'Check';

  @override
  String get level => 'Level';

  @override
  String get items => 'items';

  @override
  String get sortAscending => 'Sort ASC';

  @override
  String get sortDescending => 'Sort DESC';

  @override
  String get best => 'Best';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return 'Sort $count $type $direction';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get startChallenge => 'START CHALLENGE';

  @override
  String get completedToday => 'Completed Today!';

  @override
  String get comeBackTomorrow => 'Come back tomorrow for a new challenge';

  @override
  String get shareResult => 'Share Result';

  @override
  String get shareAchievement => 'Share Achievement';

  @override
  String get canYouBeatMyTime => 'Can you beat my time?';

  @override
  String get dailyStreak => 'Daily Streak';

  @override
  String get dailyStreakActive => 'Daily Streak Active!';

  @override
  String get categoryProgress => 'Category Progress';

  @override
  String get completedLevels => 'Completed Levels';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get longestStreak => 'Longest Streak';

  @override
  String get totalPlayTime => 'Total Play Time';

  @override
  String get totalAttempts => 'Total Attempts';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get selectLevel => 'Select Level';

  @override
  String get about => 'About';

  @override
  String get appDescription => 'Sorga - A Sorting Game';

  @override
  String get version => 'Version';

  @override
  String get levelsDescription =>
      '800 levels across 6 categories. Train your brain with numbers, time, names, and more!';

  @override
  String get dragAndDrop => 'Drag & Drop';

  @override
  String get dragItemsDescription =>
      'Drag items to rearrange them in the correct order';

  @override
  String get skip => 'Skip';

  @override
  String get next => 'NEXT';

  @override
  String get shift => 'Shift';

  @override
  String get swap => 'Swap';

  @override
  String get reset => 'Reset';

  @override
  String get daily => 'Daily';

  @override
  String get orderNotRight => 'The order was not quite right.';

  @override
  String chancesLeft(Object count) {
    return 'You have $count chance left!';
  }

  @override
  String get sort => 'Sort';

  @override
  String get asc => 'ASC';

  @override
  String get desc => 'DESC';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get getReady => 'Get Ready!';

  @override
  String get attempt => 'Attempt';

  @override
  String get noMoreChances => 'No more chances. Try again!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y completed';
  }

  @override
  String get sortTheItems => 'Sort the items';

  @override
  String get tapCheckWhenDone => 'Tap Check when you\'re done.';

  @override
  String get useDragMode => 'Use Shift or Swap mode';

  @override
  String get shiftModeDescription =>
      'Shift mode slides items. Swap mode exchanges positions.';

  @override
  String get youreReady => 'You\'re Ready!';

  @override
  String get startSorting => 'Start sorting and beat your best time!';

  @override
  String get bestTime => 'Best Time';

  @override
  String get attempts => 'Attempts';

  @override
  String get iCompletedLevel =>
      'I just completed this level in Sorga! Can you beat my time?';

  @override
  String get dailyChallengeShare => '🎯 Sorga Daily Challenge';

  @override
  String get shiftAndSwap => 'Shift & Swap';

  @override
  String get shiftAndSwapDescription =>
      'Use SHIFT mode to move items step by step, or SWAP to exchange positions';

  @override
  String get checkAnswer => 'Check Answer';

  @override
  String get checkAnswerDescription =>
      'When ready, tap CHECK to verify your answer. Good luck!';

  @override
  String get startPlaying => 'START PLAYING';

  @override
  String get january => 'January';

  @override
  String get february => 'February';

  @override
  String get march => 'March';

  @override
  String get april => 'April';

  @override
  String get may => 'May';

  @override
  String get june => 'June';

  @override
  String get july => 'July';

  @override
  String get august => 'August';

  @override
  String get september => 'September';

  @override
  String get october => 'October';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get numbers => 'numbers';

  @override
  String get times => 'times';

  @override
  String get names => 'names';

  @override
  String get memorized => 'I\'ve Memorized!';

  @override
  String get memoryMode => 'Memory';

  @override
  String get memorizeTime => 'Memorize';

  @override
  String get sortTime => 'Sort';

  @override
  String get totalTime => 'Total Time';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return 'Complete Level $level in $category to unlock';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return 'Sort $count $type $direction';
  }

  @override
  String get ascending => 'ASC';

  @override
  String get descending => 'DESC';

  @override
  String get multiplayer => 'Multiplayer';

  @override
  String get multiplayerSetup => 'Multiplayer Setup';

  @override
  String get selectCategory => 'Select Category';

  @override
  String get itemCount => 'Item Count';

  @override
  String get playerCount => 'Number of Players';

  @override
  String playerName(Object number) {
    return 'Player $number Name';
  }

  @override
  String get startGame => 'Start Game';

  @override
  String getReadyPlayer(Object name) {
    return 'Get Ready, $name!';
  }

  @override
  String get yourTurn => 'Your Turn';

  @override
  String get tapToStart => 'Tap to Start';

  @override
  String get giveUp => 'Give Up';

  @override
  String get failed => 'Failed';

  @override
  String get failedNextPlayer => 'Failed! Next...';

  @override
  String continueLeft(Object count) {
    return 'Continue ($count left)';
  }

  @override
  String get draw => 'Draw!';

  @override
  String get everyoneGaveUp => 'Everyone gave up!';

  @override
  String get everyoneFailed => 'Everyone failed!';

  @override
  String get noOneCompleted => 'No one completed!';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get localMultiplayer => 'Local Multiplayer';

  @override
  String get players => 'Players';

  @override
  String get addPlayer => 'Add Player';

  @override
  String get removePlayer => 'Remove';

  @override
  String get category => 'Category';

  @override
  String get ready => 'Ready?';

  @override
  String get go => 'GO!';
}
