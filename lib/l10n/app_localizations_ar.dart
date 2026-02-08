// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'SORTIQ';

  @override
  String get home => 'الرئيسية';

  @override
  String get play => 'العب';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get chooseCategory => 'اختر الفئة';

  @override
  String levelCompleted(Object id) {
    return 'المستوى $id مكتمل!';
  }

  @override
  String get sortItems => 'رتب العناصر';

  @override
  String get sortNames => 'رتب الأسماء';

  @override
  String get lowToHigh => 'من الأقل للأكثر';

  @override
  String get highToLow => 'من الأكثر للأقل';

  @override
  String get aToZ => 'أ → ي';

  @override
  String get zToA => 'ي → أ';

  @override
  String get nextLevel => 'المستوى التالي';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get dailyChallenge => 'التحدي اليومي';

  @override
  String get streak => 'متتالي';

  @override
  String get perfect => 'مثالي!';

  @override
  String get tryAgain => 'حاول مجدداً';

  @override
  String get completed => 'مكتمل';

  @override
  String get basicNumbers => 'أرقام أساسية';

  @override
  String get formattedNumbers => 'أرقام منسقة';

  @override
  String get timeFormats => 'صيغ الوقت';

  @override
  String get nameSorting => 'ترتيب الأسماء';

  @override
  String get mixedFormats => 'صيغ مختلطة';

  @override
  String get knowledge => 'معرفة';

  @override
  String get levels => 'مستويات';

  @override
  String get share => 'مشاركة';

  @override
  String get close => 'إغلاق';

  @override
  String get yourTime => 'وقتك';

  @override
  String get continueGame => 'استمر';

  @override
  String get retryLevel => 'إعادة المستوى';

  @override
  String get yourSortingParadise => 'جنة الترتيب الخاصة بك';

  @override
  String get done => 'تم';

  @override
  String get progress => 'التقدم';

  @override
  String get time => 'الوقت';

  @override
  String get day => 'يوم';

  @override
  String get days => 'أيام';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get soundEffects => 'المؤثرات الصوتية';

  @override
  String get vibration => 'الاهتزاز';

  @override
  String get check => 'تحقق';

  @override
  String get level => 'المستوى';

  @override
  String get items => 'عناصر';

  @override
  String get sortAscending => 'تصاعدي';

  @override
  String get sortDescending => 'تنازلي';

  @override
  String get best => 'الأفضل';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return 'رتب $count $type $direction';
  }

  @override
  String get playAgain => 'العب مجدداً';

  @override
  String get startChallenge => 'ابدأ التحدي';

  @override
  String get completedToday => 'مكتمل اليوم!';

  @override
  String get comeBackTomorrow => 'عد غداً لتحدٍ جديد';

  @override
  String get shareResult => 'شارك النتيجة';

  @override
  String get shareAchievement => 'شارك الإنجاز';

  @override
  String get canYouBeatMyTime => 'هل يمكنك التغلب على وقتي؟';

  @override
  String get dailyStreak => 'التتابع اليومي';

  @override
  String get dailyStreakActive => 'التتابع اليومي نشط!';

  @override
  String get categoryProgress => 'تقدم الفئة';

  @override
  String get completedLevels => 'المستويات المكتملة';

  @override
  String get currentStreak => 'التتابع الحالي';

  @override
  String get longestStreak => 'أطول تتابع';

  @override
  String get totalPlayTime => 'إجمالي وقت اللعب';

  @override
  String get totalAttempts => 'إجمالي المحاولات';

  @override
  String get achievementsTitle => 'الإنجازات';

  @override
  String get statisticsTitle => 'الإحصائيات';

  @override
  String get selectLevel => 'اختر المستوى';

  @override
  String get about => 'حول';

  @override
  String get appDescription => 'SORTIQ - ما مدى سرعة عقلك؟';

  @override
  String get version => 'الإصدار';

  @override
  String get levelsDescription =>
      '1100 مستوى في 11 فئة. درّب عقلك بالأرقام والوقت والأسماء والمزيد!';

  @override
  String get dragAndDrop => 'اسحب وأفلت';

  @override
  String get dragItemsDescription => 'اسحب العناصر لترتيبها بالترتيب الصحيح';

  @override
  String get skip => 'تخطي';

  @override
  String get next => 'التالي';

  @override
  String get shift => 'إزاحة';

  @override
  String get swap => 'تبديل';

  @override
  String get reset => 'إعادة تعيين';

  @override
  String get daily => 'يومي';

  @override
  String get orderNotRight => 'الترتيب لم يكن صحيحاً تماماً.';

  @override
  String chancesLeft(Object count) {
    return 'لديك $count فرصة متبقية!';
  }

  @override
  String get sort => 'رتب';

  @override
  String get asc => 'تصاعدي';

  @override
  String get desc => 'تنازلي';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get monday => 'الاثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get getReady => 'استعد!';

  @override
  String get attempt => 'محاولة';

  @override
  String get noMoreChances => 'لا مزيد من الفرص. حاول مجدداً!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y مكتمل';
  }

  @override
  String get sortTheItems => 'رتب العناصر';

  @override
  String get tapCheckWhenDone => 'اضغط تحقق عند الانتهاء.';

  @override
  String get useDragMode => 'استخدم وضع الإزاحة أو التبديل';

  @override
  String get shiftModeDescription =>
      'وضع الإزاحة يحرك العناصر. وضع التبديل يغير المواقع.';

  @override
  String get youreReady => 'أنت جاهز!';

  @override
  String get startSorting => 'ابدأ الترتيب واهزم أفضل وقتك!';

  @override
  String get bestTime => 'أفضل وقت';

  @override
  String get attempts => 'المحاولات';

  @override
  String get iCompletedLevel =>
      'أكملت هذا المستوى في SORTIQ! هل يمكنك التغلب على وقتي؟';

  @override
  String get dailyChallengeShare => '🎯 تحدي SORTIQ اليومي';

  @override
  String get shiftAndSwap => 'إزاحة وتبديل';

  @override
  String get shiftAndSwapDescription =>
      'استخدم وضع الإزاحة لتحريك العناصر خطوة بخطوة، أو التبديل لتغيير المواقع';

  @override
  String get checkAnswer => 'تحقق من الإجابة';

  @override
  String get checkAnswerDescription =>
      'عندما تكون جاهزاً، اضغط تحقق للتأكد من إجابتك. حظاً سعيداً!';

  @override
  String get startPlaying => 'ابدأ اللعب';

  @override
  String get january => 'يناير';

  @override
  String get february => 'فبراير';

  @override
  String get march => 'مارس';

  @override
  String get april => 'أبريل';

  @override
  String get may => 'مايو';

  @override
  String get june => 'يونيو';

  @override
  String get july => 'يوليو';

  @override
  String get august => 'أغسطس';

  @override
  String get september => 'سبتمبر';

  @override
  String get october => 'أكتوبر';

  @override
  String get november => 'نوفمبر';

  @override
  String get december => 'ديسمبر';

  @override
  String get numbers => 'أرقام';

  @override
  String get times => 'أوقات';

  @override
  String get names => 'أسماء';

  @override
  String get imReady => 'أنا جاهز 👁️';

  @override
  String get timeUp => 'انتهى الوقت!';

  @override
  String get tapReadyToReveal => 'اضغط \"أنا جاهز\" لإظهار العناصر';

  @override
  String get exitGame => 'الخروج من اللعبة؟';

  @override
  String get exitGameConfirm => 'سيتم فقدان تقدمك.';

  @override
  String get memorized => 'حفظتها!';

  @override
  String get memoryMode => 'الذاكرة';

  @override
  String get memorizeTime => 'احفظ';

  @override
  String get sortTime => 'رتب';

  @override
  String get totalTime => 'الوقت الإجمالي';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return 'أكمل المستوى $level في $category لفتح القفل';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return 'رتب $count $type $direction';
  }

  @override
  String get ascending => 'تصاعدي';

  @override
  String get descending => 'تنازلي';

  @override
  String get multiplayer => 'تمرير واللعب';

  @override
  String get multiplayerSetup => 'إعداد تمرير واللعب';

  @override
  String get selectCategory => 'اختر الفئة';

  @override
  String get itemCount => 'عدد العناصر';

  @override
  String get playerCount => 'عدد اللاعبين';

  @override
  String playerName(Object number) {
    return 'اسم اللاعب $number';
  }

  @override
  String get startGame => 'ابدأ اللعبة';

  @override
  String getReadyPlayer(Object name) {
    return 'استعد يا $name!';
  }

  @override
  String get yourTurn => 'دورك';

  @override
  String get tapToStart => 'اضغط للبدء';

  @override
  String get giveUp => 'استسلم';

  @override
  String get failed => 'فشل';

  @override
  String get failedNextPlayer => 'فشل! التالي...';

  @override
  String continueLeft(Object count) {
    return 'استمر ($count متبقي)';
  }

  @override
  String get draw => 'تعادل!';

  @override
  String get everyoneGaveUp => 'الجميع استسلم!';

  @override
  String get everyoneFailed => 'الجميع فشل!';

  @override
  String get noOneCompleted => 'لم يكمل أحد!';

  @override
  String get leaderboard => 'قائمة المتصدرين';

  @override
  String get localMultiplayer => 'تمرير واللعب';

  @override
  String get players => 'اللاعبون';

  @override
  String get addPlayer => 'إضافة لاعب';

  @override
  String get removePlayer => 'إزالة';

  @override
  String get category => 'الفئة';

  @override
  String get ready => 'جاهز؟';

  @override
  String get go => 'انطلق!';

  @override
  String get complete => 'مكتمل';

  @override
  String get unlocked => 'مفتوح';

  @override
  String get locked => 'مغلق';

  @override
  String get secretAchievement => 'إنجاز سري';

  @override
  String get dailyChallenges => 'التحديات اليومية';

  @override
  String get dailyCompleted => 'اليومي مكتمل';

  @override
  String get perfectCompletions => 'مثالي';

  @override
  String get multiplayerGames => 'تمرير واللعب';

  @override
  String get memoryProgress => 'تقدم الذاكرة';

  @override
  String get achFirstSteps => 'الخطوات الأولى';

  @override
  String get achFirstStepsDesc => 'أكمل مستواك الأول';

  @override
  String get achGettingStarted => 'البداية';

  @override
  String get achGettingStartedDesc => 'أكمل 10 مستويات';

  @override
  String get achOnARoll => 'على المسار الصحيح';

  @override
  String get achOnARollDesc => 'أكمل 50 مستوى';

  @override
  String get achCenturyClub => 'نادي المئة';

  @override
  String get achCenturyClubDesc => 'أكمل 100 مستوى';

  @override
  String get achHalfwayThere => 'في منتصف الطريق';

  @override
  String get achHalfwayThereDesc => 'أكمل 500 مستوى';

  @override
  String get achSortingMaster => 'سيد الترتيب';

  @override
  String get achSortingMasterDesc => 'أكمل جميع 600 مستوى';

  @override
  String get achConsistent => 'مستمر';

  @override
  String get achConsistentDesc => 'العب 3 أيام متتالية';

  @override
  String get achWeekWarrior => 'محارب الأسبوع';

  @override
  String get achWeekWarriorDesc => 'العب 7 أيام متتالية';

  @override
  String get achMonthlyMaster => 'سيد الشهر';

  @override
  String get achMonthlyMasterDesc => 'العب 30 يوماً متتالياً';

  @override
  String get achLegendaryStreak => 'تتابع أسطوري';

  @override
  String get achLegendaryStreakDesc => 'العب 100 يوم متتالي';

  @override
  String get achSpeedDemon => 'شيطان السرعة';

  @override
  String get achSpeedDemonDesc => 'أكمل مستوى في أقل من 5 ثوانٍ';

  @override
  String get achLightningFast => 'سريع كالبرق';

  @override
  String get achLightningFastDesc => 'أكمل مستوى في أقل من 3 ثوانٍ';

  @override
  String get achBasicExpert => 'خبير الأساسيات';

  @override
  String get achBasicExpertDesc => 'أكمل 100 مستوى أساسي';

  @override
  String get achFormatPro => 'محترف التنسيق';

  @override
  String get achFormatProDesc => 'أكمل 100 مستوى منسق';

  @override
  String get achTimeLord => 'سيد الوقت';

  @override
  String get achTimeLordDesc => 'أكمل 100 مستوى وقت';

  @override
  String get achAlphabetizer => 'مرتب الحروف';

  @override
  String get achAlphabetizerDesc => 'أكمل 100 مستوى أسماء';

  @override
  String get achMixMaster => 'سيد المزج';

  @override
  String get achMixMasterDesc => 'أكمل 100 مستوى مختلط';

  @override
  String get achKnowledgeKing => 'ملك المعرفة';

  @override
  String get achKnowledgeKingDesc => 'أكمل 100 مستوى معرفة';

  @override
  String get achBasicPerfectionist => 'كمالي الأساسيات';

  @override
  String get achBasicPerfectionistDesc => '100% مستويات أساسية';

  @override
  String get achFormatPerfectionist => 'كمالي التنسيق';

  @override
  String get achFormatPerfectionistDesc => '100% مستويات منسقة';

  @override
  String get achTimePerfectionist => 'كمالي الوقت';

  @override
  String get achTimePerfectionistDesc => '100% مستويات وقت';

  @override
  String get achNamesPerfectionist => 'كمالي الأسماء';

  @override
  String get achNamesPerfectionistDesc => '100% مستويات أسماء';

  @override
  String get achMixedPerfectionist => 'كمالي المختلط';

  @override
  String get achMixedPerfectionistDesc => '100% مستويات مختلطة';

  @override
  String get achKnowledgePerfectionist => 'كمالي المعرفة';

  @override
  String get achKnowledgePerfectionistDesc => '100% مستويات معرفة';

  @override
  String get achMemoryNovice => 'مبتدئ الذاكرة';

  @override
  String get achMemoryNoviceDesc => '10 مستويات ذاكرة';

  @override
  String get achMemoryExpert => 'خبير الذاكرة';

  @override
  String get achMemoryExpertDesc => '50 مستوى ذاكرة';

  @override
  String get achMemoryMaster => 'سيد الذاكرة';

  @override
  String get achMemoryMasterDesc => '100 مستوى ذاكرة';

  @override
  String get achPerfectRecall => 'استذكار مثالي';

  @override
  String get achPerfectRecallDesc => '5 مستويات ذاكرة مثالية';

  @override
  String get achMemoryPro => 'محترف الذاكرة';

  @override
  String get achMemoryProDesc => '10 مستويات ذاكرة مثالية';

  @override
  String get achMemoryGenius => 'عبقري الذاكرة';

  @override
  String get achMemoryGeniusDesc => '25 مستوى ذاكرة مثالي';

  @override
  String get achEideticMemory => 'ذاكرة فوتوغرافية';

  @override
  String get achEideticMemoryDesc => '50 مستوى ذاكرة مثالي';

  @override
  String get achPhotographicMemory => 'ذاكرة خارقة';

  @override
  String get achPhotographicMemoryDesc => '100 مستوى ذاكرة مثالي';

  @override
  String get achMemoryBasicMaster => 'سيد ذاكرة الأساسيات';

  @override
  String get achMemoryBasicMasterDesc => 'جميع الأساسيات في الذاكرة';

  @override
  String get achMemoryFormatMaster => 'سيد ذاكرة التنسيق';

  @override
  String get achMemoryFormatMasterDesc => 'جميع المنسق في الذاكرة';

  @override
  String get achMemoryTimeMaster => 'سيد ذاكرة الوقت';

  @override
  String get achMemoryTimeMasterDesc => 'جميع الوقت في الذاكرة';

  @override
  String get achMemoryNamesMaster => 'سيد ذاكرة الأسماء';

  @override
  String get achMemoryNamesMasterDesc => 'جميع الأسماء في الذاكرة';

  @override
  String get achMemoryMixedMaster => 'سيد ذاكرة المختلط';

  @override
  String get achMemoryMixedMasterDesc => 'جميع المختلط في الذاكرة';

  @override
  String get achDailyStarter => 'بداية يومية';

  @override
  String get achDailyStarterDesc => 'أول تحدي يومي';

  @override
  String get achWeeklyChallenger => 'متحدي الأسبوع';

  @override
  String get achWeeklyChallengerDesc => '7 تحديات يومية';

  @override
  String get achMonthlyChallenger => 'متحدي الشهر';

  @override
  String get achMonthlyChallengerDesc => '30 تحدي يومي';

  @override
  String get achDailyLegend => 'أسطورة يومية';

  @override
  String get achDailyLegendDesc => '100 تحدي يومي';

  @override
  String get achPerfectDay => 'يوم مثالي';

  @override
  String get achPerfectDayDesc => '5 يوميات مثالية';

  @override
  String get achPerfectWeek => 'أسبوع مثالي';

  @override
  String get achPerfectWeekDesc => '10 يوميات مثالية';

  @override
  String get achPerfectStreak => 'تتابع مثالي';

  @override
  String get achPerfectStreakDesc => '25 يومية مثالية';

  @override
  String get achFlawlessPlayer => 'لاعب بلا أخطاء';

  @override
  String get achFlawlessPlayerDesc => '50 يومية مثالية';

  @override
  String get achDailyPerfectionist => 'كمالي يومي';

  @override
  String get achDailyPerfectionistDesc => '100 يومية مثالية';

  @override
  String get achPartyHost => 'مضيف الحفلة';

  @override
  String get achPartyHostDesc => 'استضف 10 ألعاب متعددة';

  @override
  String get achSocialGamer => 'لاعب اجتماعي';

  @override
  String get achSocialGamerDesc => 'استضف 25 لعبة متعددة';

  @override
  String get achMultiplayerLegend => 'أسطورة متعدد اللاعبين';

  @override
  String get achMultiplayerLegendDesc => 'استضف 50 لعبة متعددة';

  @override
  String get achPerfectRun => 'جري مثالي';

  @override
  String get achPerfectRunDesc => '10 مستويات بدون أخطاء';

  @override
  String get achDedicatedPlayer => 'لاعب متفاني';

  @override
  String get achDedicatedPlayerDesc => 'العب ساعة إجمالياً';

  @override
  String get achMarathonRunner => 'عداء الماراثون';

  @override
  String get achMarathonRunnerDesc => 'العب 5 ساعات إجمالياً';

  @override
  String get achTotalMaster => 'السيد الشامل';

  @override
  String get achTotalMasterDesc => '1100 مستوى (عادي + ذاكرة)';

  @override
  String get achCompletionist => 'المكمل';

  @override
  String get achCompletionistDesc => 'افتح جميع الإنجازات';

  @override
  String get achNightOwl => 'بومة الليل';

  @override
  String get achNightOwlDesc => 'العب بين منتصف الليل و5 صباحاً';

  @override
  String get achEarlyBird => 'الطائر المبكر';

  @override
  String get achEarlyBirdDesc => 'العب بين 5 و7 صباحاً';

  @override
  String get achNewYearSorter => 'مرتب العام الجديد';

  @override
  String get achNewYearSorterDesc => 'العب في 1 يناير';

  @override
  String get achNeverGiveUp => 'لا تستسلم أبداً';

  @override
  String get achNeverGiveUpDesc => 'استخدم إعادة المحاولة 50 مرة';

  @override
  String get achInstantWin => 'فوز فوري';

  @override
  String get achInstantWinDesc => 'أكمل في أقل من ثانيتين';

  @override
  String get achDescendingFan => 'محب التنازلي';

  @override
  String get achDescendingFanDesc => '20 تنازلي متتالي';

  @override
  String get achSwapMaster => 'سيد التبديل';

  @override
  String get achSwapMasterDesc => '10 مستويات بالتبديل فقط';

  @override
  String get achShiftMaster => 'سيد الإزاحة';

  @override
  String get achShiftMasterDesc => '10 مستويات بالإزاحة فقط';

  @override
  String get watchAd => 'شاهد إعلاناً لفرصة إضافية';

  @override
  String get goPro => 'اشترك برو';

  @override
  String get noAds => 'بدون إعلانات';

  @override
  String get noAdsDesc => 'إزالة جميع الإعلانات';

  @override
  String get unlimitedAttempts => 'محاولات غير محدودة';

  @override
  String get unlimitedAttemptsDesc => 'لن تنفد فرصك أبداً';

  @override
  String get proBadge => 'شارة برو';

  @override
  String get proBadgeDesc => 'أظهر حالتك المميزة';

  @override
  String get supportDev => 'ادعم المطور';

  @override
  String get supportDevDesc => 'ساعدنا في إنشاء المزيد';

  @override
  String get whatYouGet => 'ما ستحصل عليه';

  @override
  String get processing => 'جارٍ المعالجة...';

  @override
  String get purchaseSuccess => 'مرحباً بك في برو!';

  @override
  String get youAreNowPro => 'لديك الآن وصول غير محدود لجميع الميزات!';

  @override
  String get ok => 'حسناً';

  @override
  String get restorePurchases => 'استعادة المشتريات';

  @override
  String get noPurchasesToRestore => 'لم يتم العثور على مشتريات سابقة';

  @override
  String get alreadyPro => 'أنت برو بالفعل!';
}
