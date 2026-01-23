import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sorga'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose Category'**
  String get chooseCategory;

  /// No description provided for @levelCompleted.
  ///
  /// In en, this message translates to:
  /// **'Level {id} Completed!'**
  String levelCompleted(Object id);

  /// No description provided for @sortItems.
  ///
  /// In en, this message translates to:
  /// **'Sort Items'**
  String get sortItems;

  /// No description provided for @sortNames.
  ///
  /// In en, this message translates to:
  /// **'Sort Names'**
  String get sortNames;

  /// No description provided for @lowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Low → High'**
  String get lowToHigh;

  /// No description provided for @highToLow.
  ///
  /// In en, this message translates to:
  /// **'High → Low'**
  String get highToLow;

  /// No description provided for @aToZ.
  ///
  /// In en, this message translates to:
  /// **'A → Z'**
  String get aToZ;

  /// No description provided for @zToA.
  ///
  /// In en, this message translates to:
  /// **'Z → A'**
  String get zToA;

  /// No description provided for @nextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get nextLevel;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @dailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyChallenge;

  /// No description provided for @streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// No description provided for @perfect.
  ///
  /// In en, this message translates to:
  /// **'PERFECT!'**
  String get perfect;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'TRY AGAIN'**
  String get tryAgain;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @basicNumbers.
  ///
  /// In en, this message translates to:
  /// **'Basic Numbers'**
  String get basicNumbers;

  /// No description provided for @formattedNumbers.
  ///
  /// In en, this message translates to:
  /// **'Formatted'**
  String get formattedNumbers;

  /// No description provided for @timeFormats.
  ///
  /// In en, this message translates to:
  /// **'Time Formats'**
  String get timeFormats;

  /// No description provided for @nameSorting.
  ///
  /// In en, this message translates to:
  /// **'Name Sorting'**
  String get nameSorting;

  /// No description provided for @mixedFormats.
  ///
  /// In en, this message translates to:
  /// **'Mixed Formats'**
  String get mixedFormats;

  /// No description provided for @knowledge.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get knowledge;

  /// No description provided for @levels.
  ///
  /// In en, this message translates to:
  /// **'levels'**
  String get levels;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @yourTime.
  ///
  /// In en, this message translates to:
  /// **'YOUR TIME'**
  String get yourTime;

  /// No description provided for @continueGame.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueGame;

  /// No description provided for @retryLevel.
  ///
  /// In en, this message translates to:
  /// **'RETRY LEVEL'**
  String get retryLevel;

  /// No description provided for @yourSortingParadise.
  ///
  /// In en, this message translates to:
  /// **'Your Sorting Paradise'**
  String get yourSortingParadise;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @soundEffects.
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// No description provided for @vibration.
  ///
  /// In en, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @check.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get check;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @sortAscending.
  ///
  /// In en, this message translates to:
  /// **'Sort ASC'**
  String get sortAscending;

  /// No description provided for @sortDescending.
  ///
  /// In en, this message translates to:
  /// **'Sort DESC'**
  String get sortDescending;

  /// No description provided for @best.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get best;

  /// No description provided for @sortXItems.
  ///
  /// In en, this message translates to:
  /// **'Sort {count} {type} {direction}'**
  String sortXItems(Object count, Object type, Object direction);

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @startChallenge.
  ///
  /// In en, this message translates to:
  /// **'START CHALLENGE'**
  String get startChallenge;

  /// No description provided for @completedToday.
  ///
  /// In en, this message translates to:
  /// **'Completed Today!'**
  String get completedToday;

  /// No description provided for @comeBackTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Come back tomorrow for a new challenge'**
  String get comeBackTomorrow;

  /// No description provided for @shareResult.
  ///
  /// In en, this message translates to:
  /// **'Share Result'**
  String get shareResult;

  /// No description provided for @shareAchievement.
  ///
  /// In en, this message translates to:
  /// **'Share Achievement'**
  String get shareAchievement;

  /// No description provided for @canYouBeatMyTime.
  ///
  /// In en, this message translates to:
  /// **'Can you beat my time?'**
  String get canYouBeatMyTime;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak'**
  String get dailyStreak;

  /// No description provided for @dailyStreakActive.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak Active!'**
  String get dailyStreakActive;

  /// No description provided for @categoryProgress.
  ///
  /// In en, this message translates to:
  /// **'Category Progress'**
  String get categoryProgress;

  /// No description provided for @completedLevels.
  ///
  /// In en, this message translates to:
  /// **'Completed Levels'**
  String get completedLevels;

  /// No description provided for @currentStreak.
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// No description provided for @longestStreak.
  ///
  /// In en, this message translates to:
  /// **'Longest Streak'**
  String get longestStreak;

  /// No description provided for @totalPlayTime.
  ///
  /// In en, this message translates to:
  /// **'Total Play Time'**
  String get totalPlayTime;

  /// No description provided for @totalAttempts.
  ///
  /// In en, this message translates to:
  /// **'Total Attempts'**
  String get totalAttempts;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @statisticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTitle;

  /// No description provided for @selectLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Level'**
  String get selectLevel;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Sorga - A Sorting Game'**
  String get appDescription;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @levelsDescription.
  ///
  /// In en, this message translates to:
  /// **'800 levels across 6 categories. Train your brain with numbers, time, names, and more!'**
  String get levelsDescription;

  /// No description provided for @dragAndDrop.
  ///
  /// In en, this message translates to:
  /// **'Drag & Drop'**
  String get dragAndDrop;

  /// No description provided for @dragItemsDescription.
  ///
  /// In en, this message translates to:
  /// **'Drag items to rearrange them in the correct order'**
  String get dragItemsDescription;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// No description provided for @shift.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shift;

  /// No description provided for @swap.
  ///
  /// In en, this message translates to:
  /// **'Swap'**
  String get swap;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @orderNotRight.
  ///
  /// In en, this message translates to:
  /// **'The order was not quite right.'**
  String get orderNotRight;

  /// No description provided for @chancesLeft.
  ///
  /// In en, this message translates to:
  /// **'You have {count} chance left!'**
  String chancesLeft(Object count);

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @asc.
  ///
  /// In en, this message translates to:
  /// **'ASC'**
  String get asc;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'DESC'**
  String get desc;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @getReady.
  ///
  /// In en, this message translates to:
  /// **'Get Ready!'**
  String get getReady;

  /// No description provided for @attempt.
  ///
  /// In en, this message translates to:
  /// **'Attempt'**
  String get attempt;

  /// No description provided for @noMoreChances.
  ///
  /// In en, this message translates to:
  /// **'No more chances. Try again!'**
  String get noMoreChances;

  /// No description provided for @xOfYCompleted.
  ///
  /// In en, this message translates to:
  /// **'{x} / {y} completed'**
  String xOfYCompleted(Object x, Object y);

  /// No description provided for @sortTheItems.
  ///
  /// In en, this message translates to:
  /// **'Sort the items'**
  String get sortTheItems;

  /// No description provided for @tapCheckWhenDone.
  ///
  /// In en, this message translates to:
  /// **'Tap Check when you\'re done.'**
  String get tapCheckWhenDone;

  /// No description provided for @useDragMode.
  ///
  /// In en, this message translates to:
  /// **'Use Shift or Swap mode'**
  String get useDragMode;

  /// No description provided for @shiftModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Shift mode slides items. Swap mode exchanges positions.'**
  String get shiftModeDescription;

  /// No description provided for @youreReady.
  ///
  /// In en, this message translates to:
  /// **'You\'re Ready!'**
  String get youreReady;

  /// No description provided for @startSorting.
  ///
  /// In en, this message translates to:
  /// **'Start sorting and beat your best time!'**
  String get startSorting;

  /// No description provided for @bestTime.
  ///
  /// In en, this message translates to:
  /// **'Best Time'**
  String get bestTime;

  /// No description provided for @attempts.
  ///
  /// In en, this message translates to:
  /// **'Attempts'**
  String get attempts;

  /// No description provided for @iCompletedLevel.
  ///
  /// In en, this message translates to:
  /// **'I just completed this level in Sorga! Can you beat my time?'**
  String get iCompletedLevel;

  /// No description provided for @dailyChallengeShare.
  ///
  /// In en, this message translates to:
  /// **'🎯 Sorga Daily Challenge'**
  String get dailyChallengeShare;

  /// No description provided for @shiftAndSwap.
  ///
  /// In en, this message translates to:
  /// **'Shift & Swap'**
  String get shiftAndSwap;

  /// No description provided for @shiftAndSwapDescription.
  ///
  /// In en, this message translates to:
  /// **'Use SHIFT mode to move items step by step, or SWAP to exchange positions'**
  String get shiftAndSwapDescription;

  /// No description provided for @checkAnswer.
  ///
  /// In en, this message translates to:
  /// **'Check Answer'**
  String get checkAnswer;

  /// No description provided for @checkAnswerDescription.
  ///
  /// In en, this message translates to:
  /// **'When ready, tap CHECK to verify your answer. Good luck!'**
  String get checkAnswerDescription;

  /// No description provided for @startPlaying.
  ///
  /// In en, this message translates to:
  /// **'START PLAYING'**
  String get startPlaying;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'numbers'**
  String get numbers;

  /// No description provided for @times.
  ///
  /// In en, this message translates to:
  /// **'times'**
  String get times;

  /// No description provided for @names.
  ///
  /// In en, this message translates to:
  /// **'Names'**
  String get names;

  /// No description provided for @memorized.
  ///
  /// In en, this message translates to:
  /// **'I\'ve Memorized!'**
  String get memorized;

  /// No description provided for @memoryMode.
  ///
  /// In en, this message translates to:
  /// **'Memory'**
  String get memoryMode;

  /// No description provided for @memorizeTime.
  ///
  /// In en, this message translates to:
  /// **'Memorize'**
  String get memorizeTime;

  /// No description provided for @sortTime.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sortTime;

  /// No description provided for @totalTime.
  ///
  /// In en, this message translates to:
  /// **'Total Time'**
  String get totalTime;

  /// No description provided for @completeLevelToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Complete Level {level} in {category} to unlock'**
  String completeLevelToUnlock(Object level, Object category);

  /// No description provided for @sortDescription.
  ///
  /// In en, this message translates to:
  /// **'Sort {count} {type} {direction}'**
  String sortDescription(Object count, Object type, Object direction);

  /// No description provided for @ascending.
  ///
  /// In en, this message translates to:
  /// **'ASC'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In en, this message translates to:
  /// **'DESC'**
  String get descending;

  /// No description provided for @multiplayer.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer'**
  String get multiplayer;

  /// No description provided for @multiplayerSetup.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer Setup'**
  String get multiplayerSetup;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'Item Count'**
  String get itemCount;

  /// No description provided for @playerCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Players'**
  String get playerCount;

  /// No description provided for @playerName.
  ///
  /// In en, this message translates to:
  /// **'Player {number} Name'**
  String playerName(Object number);

  /// No description provided for @startGame.
  ///
  /// In en, this message translates to:
  /// **'Start Game'**
  String get startGame;

  /// No description provided for @getReadyPlayer.
  ///
  /// In en, this message translates to:
  /// **'Get Ready, {name}!'**
  String getReadyPlayer(Object name);

  /// No description provided for @yourTurn.
  ///
  /// In en, this message translates to:
  /// **'It\'s Your Turn!'**
  String get yourTurn;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to Start'**
  String get tapToStart;

  /// No description provided for @giveUp.
  ///
  /// In en, this message translates to:
  /// **'Give Up'**
  String get giveUp;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @failedNextPlayer.
  ///
  /// In en, this message translates to:
  /// **'Failed! Next...'**
  String get failedNextPlayer;

  /// No description provided for @continueLeft.
  ///
  /// In en, this message translates to:
  /// **'Continue ({count} left)'**
  String continueLeft(Object count);

  /// No description provided for @draw.
  ///
  /// In en, this message translates to:
  /// **'Draw!'**
  String get draw;

  /// No description provided for @everyoneGaveUp.
  ///
  /// In en, this message translates to:
  /// **'Everyone gave up!'**
  String get everyoneGaveUp;

  /// No description provided for @everyoneFailed.
  ///
  /// In en, this message translates to:
  /// **'Everyone failed!'**
  String get everyoneFailed;

  /// No description provided for @noOneCompleted.
  ///
  /// In en, this message translates to:
  /// **'No one completed!'**
  String get noOneCompleted;

  /// No description provided for @leaderboard.
  ///
  /// In en, this message translates to:
  /// **'Leaderboard'**
  String get leaderboard;

  /// No description provided for @localMultiplayer.
  ///
  /// In en, this message translates to:
  /// **'Local Multiplayer'**
  String get localMultiplayer;

  /// No description provided for @players.
  ///
  /// In en, this message translates to:
  /// **'Players'**
  String get players;

  /// No description provided for @addPlayer.
  ///
  /// In en, this message translates to:
  /// **'Add Player'**
  String get addPlayer;

  /// No description provided for @removePlayer.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removePlayer;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready?'**
  String get ready;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'GO!'**
  String get go;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'complete'**
  String get complete;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'unlocked'**
  String get unlocked;

  /// No description provided for @locked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get locked;

  /// No description provided for @secretAchievement.
  ///
  /// In en, this message translates to:
  /// **'Secret achievement'**
  String get secretAchievement;

  /// No description provided for @dailyChallenges.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenges'**
  String get dailyChallenges;

  /// No description provided for @dailyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Daily Completed'**
  String get dailyCompleted;

  /// No description provided for @perfectCompletions.
  ///
  /// In en, this message translates to:
  /// **'Perfect'**
  String get perfectCompletions;

  /// No description provided for @multiplayerGames.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer'**
  String get multiplayerGames;

  /// No description provided for @achFirstSteps.
  ///
  /// In en, this message translates to:
  /// **'First Steps'**
  String get achFirstSteps;

  /// No description provided for @achFirstStepsDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first level'**
  String get achFirstStepsDesc;

  /// No description provided for @achGettingStarted.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get achGettingStarted;

  /// No description provided for @achGettingStartedDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 10 levels'**
  String get achGettingStartedDesc;

  /// No description provided for @achOnARoll.
  ///
  /// In en, this message translates to:
  /// **'On a Roll'**
  String get achOnARoll;

  /// No description provided for @achOnARollDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 50 levels'**
  String get achOnARollDesc;

  /// No description provided for @achCenturyClub.
  ///
  /// In en, this message translates to:
  /// **'Century Club'**
  String get achCenturyClub;

  /// No description provided for @achCenturyClubDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 levels'**
  String get achCenturyClubDesc;

  /// No description provided for @achHalfwayThere.
  ///
  /// In en, this message translates to:
  /// **'Halfway There'**
  String get achHalfwayThere;

  /// No description provided for @achHalfwayThereDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 500 levels'**
  String get achHalfwayThereDesc;

  /// No description provided for @achSortingMaster.
  ///
  /// In en, this message translates to:
  /// **'Sorting Master'**
  String get achSortingMaster;

  /// No description provided for @achSortingMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete all 600 levels'**
  String get achSortingMasterDesc;

  /// No description provided for @achConsistent.
  ///
  /// In en, this message translates to:
  /// **'Consistent'**
  String get achConsistent;

  /// No description provided for @achConsistentDesc.
  ///
  /// In en, this message translates to:
  /// **'Play 3 days in a row'**
  String get achConsistentDesc;

  /// No description provided for @achWeekWarrior.
  ///
  /// In en, this message translates to:
  /// **'Week Warrior'**
  String get achWeekWarrior;

  /// No description provided for @achWeekWarriorDesc.
  ///
  /// In en, this message translates to:
  /// **'Play 7 days in a row'**
  String get achWeekWarriorDesc;

  /// No description provided for @achMonthlyMaster.
  ///
  /// In en, this message translates to:
  /// **'Monthly Master'**
  String get achMonthlyMaster;

  /// No description provided for @achMonthlyMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Play 30 days in a row'**
  String get achMonthlyMasterDesc;

  /// No description provided for @achLegendaryStreak.
  ///
  /// In en, this message translates to:
  /// **'Legendary Streak'**
  String get achLegendaryStreak;

  /// No description provided for @achLegendaryStreakDesc.
  ///
  /// In en, this message translates to:
  /// **'Play 100 days in a row'**
  String get achLegendaryStreakDesc;

  /// No description provided for @achSpeedDemon.
  ///
  /// In en, this message translates to:
  /// **'Speed Demon'**
  String get achSpeedDemon;

  /// No description provided for @achSpeedDemonDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete level in under 5s'**
  String get achSpeedDemonDesc;

  /// No description provided for @achLightningFast.
  ///
  /// In en, this message translates to:
  /// **'Lightning Fast'**
  String get achLightningFast;

  /// No description provided for @achLightningFastDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete level in under 3s'**
  String get achLightningFastDesc;

  /// No description provided for @achBasicExpert.
  ///
  /// In en, this message translates to:
  /// **'Basic Expert'**
  String get achBasicExpert;

  /// No description provided for @achBasicExpertDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 basic levels'**
  String get achBasicExpertDesc;

  /// No description provided for @achFormatPro.
  ///
  /// In en, this message translates to:
  /// **'Format Pro'**
  String get achFormatPro;

  /// No description provided for @achFormatProDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 formatted levels'**
  String get achFormatProDesc;

  /// No description provided for @achTimeLord.
  ///
  /// In en, this message translates to:
  /// **'Time Lord'**
  String get achTimeLord;

  /// No description provided for @achTimeLordDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 time levels'**
  String get achTimeLordDesc;

  /// No description provided for @achAlphabetizer.
  ///
  /// In en, this message translates to:
  /// **'Alphabetizer'**
  String get achAlphabetizer;

  /// No description provided for @achAlphabetizerDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 name levels'**
  String get achAlphabetizerDesc;

  /// No description provided for @achMixMaster.
  ///
  /// In en, this message translates to:
  /// **'Mix Master'**
  String get achMixMaster;

  /// No description provided for @achMixMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 mixed levels'**
  String get achMixMasterDesc;

  /// No description provided for @achKnowledgeKing.
  ///
  /// In en, this message translates to:
  /// **'Knowledge King'**
  String get achKnowledgeKing;

  /// No description provided for @achKnowledgeKingDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete 100 knowledge levels'**
  String get achKnowledgeKingDesc;

  /// No description provided for @achBasicPerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Basic Perfectionist'**
  String get achBasicPerfectionist;

  /// No description provided for @achBasicPerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100% basic levels'**
  String get achBasicPerfectionistDesc;

  /// No description provided for @achFormatPerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Format Perfectionist'**
  String get achFormatPerfectionist;

  /// No description provided for @achFormatPerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100% formatted levels'**
  String get achFormatPerfectionistDesc;

  /// No description provided for @achTimePerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Time Perfectionist'**
  String get achTimePerfectionist;

  /// No description provided for @achTimePerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100% time levels'**
  String get achTimePerfectionistDesc;

  /// No description provided for @achNamesPerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Names Perfectionist'**
  String get achNamesPerfectionist;

  /// No description provided for @achNamesPerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100% name levels'**
  String get achNamesPerfectionistDesc;

  /// No description provided for @achMixedPerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Mixed Perfectionist'**
  String get achMixedPerfectionist;

  /// No description provided for @achMixedPerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100% mixed levels'**
  String get achMixedPerfectionistDesc;

  /// No description provided for @achKnowledgePerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Knowledge Perfectionist'**
  String get achKnowledgePerfectionist;

  /// No description provided for @achKnowledgePerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100% knowledge levels'**
  String get achKnowledgePerfectionistDesc;

  /// No description provided for @achMemoryNovice.
  ///
  /// In en, this message translates to:
  /// **'Memory Novice'**
  String get achMemoryNovice;

  /// No description provided for @achMemoryNoviceDesc.
  ///
  /// In en, this message translates to:
  /// **'10 Memory levels'**
  String get achMemoryNoviceDesc;

  /// No description provided for @achMemoryExpert.
  ///
  /// In en, this message translates to:
  /// **'Memory Expert'**
  String get achMemoryExpert;

  /// No description provided for @achMemoryExpertDesc.
  ///
  /// In en, this message translates to:
  /// **'50 Memory levels'**
  String get achMemoryExpertDesc;

  /// No description provided for @achMemoryMaster.
  ///
  /// In en, this message translates to:
  /// **'Memory Master'**
  String get achMemoryMaster;

  /// No description provided for @achMemoryMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'100 Memory levels'**
  String get achMemoryMasterDesc;

  /// No description provided for @achPerfectRecall.
  ///
  /// In en, this message translates to:
  /// **'Perfect Recall'**
  String get achPerfectRecall;

  /// No description provided for @achPerfectRecallDesc.
  ///
  /// In en, this message translates to:
  /// **'5 perfect Memory levels'**
  String get achPerfectRecallDesc;

  /// No description provided for @achMemoryPro.
  ///
  /// In en, this message translates to:
  /// **'Memory Pro'**
  String get achMemoryPro;

  /// No description provided for @achMemoryProDesc.
  ///
  /// In en, this message translates to:
  /// **'10 perfect Memory levels'**
  String get achMemoryProDesc;

  /// No description provided for @achMemoryGenius.
  ///
  /// In en, this message translates to:
  /// **'Memory Genius'**
  String get achMemoryGenius;

  /// No description provided for @achMemoryGeniusDesc.
  ///
  /// In en, this message translates to:
  /// **'25 perfect Memory levels'**
  String get achMemoryGeniusDesc;

  /// No description provided for @achEideticMemory.
  ///
  /// In en, this message translates to:
  /// **'Eidetic Memory'**
  String get achEideticMemory;

  /// No description provided for @achEideticMemoryDesc.
  ///
  /// In en, this message translates to:
  /// **'50 perfect Memory levels'**
  String get achEideticMemoryDesc;

  /// No description provided for @achPhotographicMemory.
  ///
  /// In en, this message translates to:
  /// **'Photographic Memory'**
  String get achPhotographicMemory;

  /// No description provided for @achPhotographicMemoryDesc.
  ///
  /// In en, this message translates to:
  /// **'100 perfect Memory levels'**
  String get achPhotographicMemoryDesc;

  /// No description provided for @achMemoryBasicMaster.
  ///
  /// In en, this message translates to:
  /// **'Memory Basic Master'**
  String get achMemoryBasicMaster;

  /// No description provided for @achMemoryBasicMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'All basic in Memory'**
  String get achMemoryBasicMasterDesc;

  /// No description provided for @achMemoryFormatMaster.
  ///
  /// In en, this message translates to:
  /// **'Memory Format Master'**
  String get achMemoryFormatMaster;

  /// No description provided for @achMemoryFormatMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'All formatted in Memory'**
  String get achMemoryFormatMasterDesc;

  /// No description provided for @achMemoryTimeMaster.
  ///
  /// In en, this message translates to:
  /// **'Memory Time Master'**
  String get achMemoryTimeMaster;

  /// No description provided for @achMemoryTimeMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'All time in Memory'**
  String get achMemoryTimeMasterDesc;

  /// No description provided for @achMemoryNamesMaster.
  ///
  /// In en, this message translates to:
  /// **'Memory Names Master'**
  String get achMemoryNamesMaster;

  /// No description provided for @achMemoryNamesMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'All names in Memory'**
  String get achMemoryNamesMasterDesc;

  /// No description provided for @achMemoryMixedMaster.
  ///
  /// In en, this message translates to:
  /// **'Memory Mixed Master'**
  String get achMemoryMixedMaster;

  /// No description provided for @achMemoryMixedMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'All mixed in Memory'**
  String get achMemoryMixedMasterDesc;

  /// No description provided for @achDailyStarter.
  ///
  /// In en, this message translates to:
  /// **'Daily Starter'**
  String get achDailyStarter;

  /// No description provided for @achDailyStarterDesc.
  ///
  /// In en, this message translates to:
  /// **'First daily challenge'**
  String get achDailyStarterDesc;

  /// No description provided for @achWeeklyChallenger.
  ///
  /// In en, this message translates to:
  /// **'Weekly Challenger'**
  String get achWeeklyChallenger;

  /// No description provided for @achWeeklyChallengerDesc.
  ///
  /// In en, this message translates to:
  /// **'7 daily challenges'**
  String get achWeeklyChallengerDesc;

  /// No description provided for @achMonthlyChallenger.
  ///
  /// In en, this message translates to:
  /// **'Monthly Challenger'**
  String get achMonthlyChallenger;

  /// No description provided for @achMonthlyChallengerDesc.
  ///
  /// In en, this message translates to:
  /// **'30 daily challenges'**
  String get achMonthlyChallengerDesc;

  /// No description provided for @achDailyLegend.
  ///
  /// In en, this message translates to:
  /// **'Daily Legend'**
  String get achDailyLegend;

  /// No description provided for @achDailyLegendDesc.
  ///
  /// In en, this message translates to:
  /// **'100 daily challenges'**
  String get achDailyLegendDesc;

  /// No description provided for @achPerfectDay.
  ///
  /// In en, this message translates to:
  /// **'Perfect Day'**
  String get achPerfectDay;

  /// No description provided for @achPerfectDayDesc.
  ///
  /// In en, this message translates to:
  /// **'5 perfect daily'**
  String get achPerfectDayDesc;

  /// No description provided for @achPerfectWeek.
  ///
  /// In en, this message translates to:
  /// **'Perfect Week'**
  String get achPerfectWeek;

  /// No description provided for @achPerfectWeekDesc.
  ///
  /// In en, this message translates to:
  /// **'10 perfect daily'**
  String get achPerfectWeekDesc;

  /// No description provided for @achPerfectStreak.
  ///
  /// In en, this message translates to:
  /// **'Perfect Streak'**
  String get achPerfectStreak;

  /// No description provided for @achPerfectStreakDesc.
  ///
  /// In en, this message translates to:
  /// **'25 perfect daily'**
  String get achPerfectStreakDesc;

  /// No description provided for @achFlawlessPlayer.
  ///
  /// In en, this message translates to:
  /// **'Flawless Player'**
  String get achFlawlessPlayer;

  /// No description provided for @achFlawlessPlayerDesc.
  ///
  /// In en, this message translates to:
  /// **'50 perfect daily'**
  String get achFlawlessPlayerDesc;

  /// No description provided for @achDailyPerfectionist.
  ///
  /// In en, this message translates to:
  /// **'Daily Perfectionist'**
  String get achDailyPerfectionist;

  /// No description provided for @achDailyPerfectionistDesc.
  ///
  /// In en, this message translates to:
  /// **'100 perfect daily'**
  String get achDailyPerfectionistDesc;

  /// No description provided for @achPartyHost.
  ///
  /// In en, this message translates to:
  /// **'Party Host'**
  String get achPartyHost;

  /// No description provided for @achPartyHostDesc.
  ///
  /// In en, this message translates to:
  /// **'Host 10 multiplayer games'**
  String get achPartyHostDesc;

  /// No description provided for @achSocialGamer.
  ///
  /// In en, this message translates to:
  /// **'Social Gamer'**
  String get achSocialGamer;

  /// No description provided for @achSocialGamerDesc.
  ///
  /// In en, this message translates to:
  /// **'Host 25 multiplayer games'**
  String get achSocialGamerDesc;

  /// No description provided for @achMultiplayerLegend.
  ///
  /// In en, this message translates to:
  /// **'Multiplayer Legend'**
  String get achMultiplayerLegend;

  /// No description provided for @achMultiplayerLegendDesc.
  ///
  /// In en, this message translates to:
  /// **'Host 50 multiplayer games'**
  String get achMultiplayerLegendDesc;

  /// No description provided for @achPerfectRun.
  ///
  /// In en, this message translates to:
  /// **'Perfect Run'**
  String get achPerfectRun;

  /// No description provided for @achPerfectRunDesc.
  ///
  /// In en, this message translates to:
  /// **'10 levels without mistakes'**
  String get achPerfectRunDesc;

  /// No description provided for @achDedicatedPlayer.
  ///
  /// In en, this message translates to:
  /// **'Dedicated Player'**
  String get achDedicatedPlayer;

  /// No description provided for @achDedicatedPlayerDesc.
  ///
  /// In en, this message translates to:
  /// **'Play for 1 hour total'**
  String get achDedicatedPlayerDesc;

  /// No description provided for @achMarathonRunner.
  ///
  /// In en, this message translates to:
  /// **'Marathon Runner'**
  String get achMarathonRunner;

  /// No description provided for @achMarathonRunnerDesc.
  ///
  /// In en, this message translates to:
  /// **'Play for 5 hours total'**
  String get achMarathonRunnerDesc;

  /// No description provided for @achTotalMaster.
  ///
  /// In en, this message translates to:
  /// **'Total Master'**
  String get achTotalMaster;

  /// No description provided for @achTotalMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'1100 levels (regular + Memory)'**
  String get achTotalMasterDesc;

  /// No description provided for @achCompletionist.
  ///
  /// In en, this message translates to:
  /// **'Completionist'**
  String get achCompletionist;

  /// No description provided for @achCompletionistDesc.
  ///
  /// In en, this message translates to:
  /// **'Unlock all achievements'**
  String get achCompletionistDesc;

  /// No description provided for @achNightOwl.
  ///
  /// In en, this message translates to:
  /// **'Night Owl'**
  String get achNightOwl;

  /// No description provided for @achNightOwlDesc.
  ///
  /// In en, this message translates to:
  /// **'Play between midnight and 5 AM'**
  String get achNightOwlDesc;

  /// No description provided for @achEarlyBird.
  ///
  /// In en, this message translates to:
  /// **'Early Bird'**
  String get achEarlyBird;

  /// No description provided for @achEarlyBirdDesc.
  ///
  /// In en, this message translates to:
  /// **'Play between 5 AM and 7 AM'**
  String get achEarlyBirdDesc;

  /// No description provided for @achNewYearSorter.
  ///
  /// In en, this message translates to:
  /// **'New Year Sorter'**
  String get achNewYearSorter;

  /// No description provided for @achNewYearSorterDesc.
  ///
  /// In en, this message translates to:
  /// **'Play on January 1st'**
  String get achNewYearSorterDesc;

  /// No description provided for @achNeverGiveUp.
  ///
  /// In en, this message translates to:
  /// **'Never Give Up'**
  String get achNeverGiveUp;

  /// No description provided for @achNeverGiveUpDesc.
  ///
  /// In en, this message translates to:
  /// **'Use retry 50 times'**
  String get achNeverGiveUpDesc;

  /// No description provided for @achInstantWin.
  ///
  /// In en, this message translates to:
  /// **'Instant Win'**
  String get achInstantWin;

  /// No description provided for @achInstantWinDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete in under 2s'**
  String get achInstantWinDesc;

  /// No description provided for @achDescendingFan.
  ///
  /// In en, this message translates to:
  /// **'Descending Fan'**
  String get achDescendingFan;

  /// No description provided for @achDescendingFanDesc.
  ///
  /// In en, this message translates to:
  /// **'20 descending in a row'**
  String get achDescendingFanDesc;

  /// No description provided for @achSwapMaster.
  ///
  /// In en, this message translates to:
  /// **'Swap Master'**
  String get achSwapMaster;

  /// No description provided for @achSwapMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'10 levels using only swap'**
  String get achSwapMasterDesc;

  /// No description provided for @achShiftMaster.
  ///
  /// In en, this message translates to:
  /// **'Shift Master'**
  String get achShiftMaster;

  /// No description provided for @achShiftMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'10 levels using only shift'**
  String get achShiftMasterDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'id',
    'ja',
    'ko',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
