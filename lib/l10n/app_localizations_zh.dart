// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'SORTIQ';

  @override
  String get home => '首页';

  @override
  String get play => '开始';

  @override
  String get achievements => '成就';

  @override
  String get statistics => '统计';

  @override
  String get chooseCategory => '选择类别';

  @override
  String levelCompleted(Object id) {
    return '第 $id 关已完成！';
  }

  @override
  String get sortItems => '排列项目';

  @override
  String get sortNames => '排列名字';

  @override
  String get lowToHigh => '从低到高';

  @override
  String get highToLow => '从高到低';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => '下一关';

  @override
  String get retry => '重试';

  @override
  String get dailyChallenge => '每日挑战';

  @override
  String get streak => '连续';

  @override
  String get perfect => '完美！';

  @override
  String get tryAgain => '再试一次';

  @override
  String get completed => '已完成';

  @override
  String get basicNumbers => '基础数字';

  @override
  String get formattedNumbers => '格式数字';

  @override
  String get timeFormats => '时间格式';

  @override
  String get nameSorting => '名字排序';

  @override
  String get mixedFormats => '混合格式';

  @override
  String get knowledge => '知识';

  @override
  String get levels => '关卡';

  @override
  String get share => '分享';

  @override
  String get close => '关闭';

  @override
  String get yourTime => '你的时间';

  @override
  String get continueGame => '继续';

  @override
  String get retryLevel => '重玩本关';

  @override
  String get yourSortingParadise => '你的排序天堂';

  @override
  String get done => '完成';

  @override
  String get progress => '进度';

  @override
  String get time => '时间';

  @override
  String get day => '天';

  @override
  String get days => '天';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get systemDefault => '系统默认';

  @override
  String get soundEffects => '音效';

  @override
  String get vibration => '震动';

  @override
  String get check => '检查';

  @override
  String get level => '关卡';

  @override
  String get items => '项目';

  @override
  String get sortAscending => '升序';

  @override
  String get sortDescending => '降序';

  @override
  String get best => '最佳';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return '排列 $count 个$type $direction';
  }

  @override
  String get playAgain => '再玩一次';

  @override
  String get startChallenge => '开始挑战';

  @override
  String get completedToday => '今日已完成！';

  @override
  String get comeBackTomorrow => '明天再来挑战新关卡';

  @override
  String get shareResult => '分享结果';

  @override
  String get shareAchievement => '分享成就';

  @override
  String get canYouBeatMyTime => '你能打破我的记录吗？';

  @override
  String get dailyStreak => '每日连胜';

  @override
  String get dailyStreakActive => '每日连胜进行中！';

  @override
  String get categoryProgress => '类别进度';

  @override
  String get completedLevels => '已完成关卡';

  @override
  String get currentStreak => '当前连胜';

  @override
  String get longestStreak => '最长连胜';

  @override
  String get totalPlayTime => '总游戏时间';

  @override
  String get totalAttempts => '总尝试次数';

  @override
  String get achievementsTitle => '成就';

  @override
  String get statisticsTitle => '统计';

  @override
  String get selectLevel => '选择关卡';

  @override
  String get about => '关于';

  @override
  String get appDescription => 'SORTIQ - 你的大脑有多快？';

  @override
  String get version => '版本';

  @override
  String get levelsDescription => '11个类别共1100关。用数字、时间、名字等训练你的大脑！';

  @override
  String get dragAndDrop => '拖放';

  @override
  String get dragItemsDescription => '拖动项目按正确顺序排列';

  @override
  String get skip => '跳过';

  @override
  String get next => '下一步';

  @override
  String get shift => '移动';

  @override
  String get swap => '交换';

  @override
  String get reset => '重置';

  @override
  String get daily => '每日';

  @override
  String get orderNotRight => '顺序不太对。';

  @override
  String chancesLeft(Object count) {
    return '还有 $count 次机会！';
  }

  @override
  String get sort => '排序';

  @override
  String get asc => '升序';

  @override
  String get desc => '降序';

  @override
  String get thursday => '星期四';

  @override
  String get friday => '星期五';

  @override
  String get saturday => '星期六';

  @override
  String get sunday => '星期日';

  @override
  String get monday => '星期一';

  @override
  String get tuesday => '星期二';

  @override
  String get wednesday => '星期三';

  @override
  String get getReady => '准备好！';

  @override
  String get attempt => '尝试';

  @override
  String get noMoreChances => '没有机会了。再试一次！';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y 已完成';
  }

  @override
  String get sortTheItems => '排列项目';

  @override
  String get tapCheckWhenDone => '完成后点击检查。';

  @override
  String get useDragMode => '使用移动或交换模式';

  @override
  String get shiftModeDescription => '移动模式滑动项目。交换模式交换位置。';

  @override
  String get youreReady => '准备好了！';

  @override
  String get startSorting => '开始排序，打破你的最佳记录！';

  @override
  String get bestTime => '最佳时间';

  @override
  String get attempts => '尝试次数';

  @override
  String get iCompletedLevel => '我在SORTIQ完成了这一关！你能打破我的记录吗？';

  @override
  String get dailyChallengeShare => '🎯 SORTIQ 每日挑战';

  @override
  String get shiftAndSwap => '移动与交换';

  @override
  String get shiftAndSwapDescription => '使用移动模式逐步移动项目，或使用交换模式交换位置';

  @override
  String get checkAnswer => '检查答案';

  @override
  String get checkAnswerDescription => '准备好后，点击检查验证答案。祝你好运！';

  @override
  String get startPlaying => '开始游戏';

  @override
  String get january => '一月';

  @override
  String get february => '二月';

  @override
  String get march => '三月';

  @override
  String get april => '四月';

  @override
  String get may => '五月';

  @override
  String get june => '六月';

  @override
  String get july => '七月';

  @override
  String get august => '八月';

  @override
  String get september => '九月';

  @override
  String get october => '十月';

  @override
  String get november => '十一月';

  @override
  String get december => '十二月';

  @override
  String get numbers => '数字';

  @override
  String get times => '时间';

  @override
  String get names => '名字';

  @override
  String get imReady => '我准备好了 👁️';

  @override
  String get timeUp => '时间到！';

  @override
  String get tapReadyToReveal => '点击\"我准备好了\"显示项目';

  @override
  String get exitGame => '退出游戏？';

  @override
  String get exitGameConfirm => '你的进度将会丢失。';

  @override
  String get memorized => '我记住了！';

  @override
  String get memoryMode => '记忆';

  @override
  String get memorizeTime => '记忆';

  @override
  String get sortTime => '排序';

  @override
  String get totalTime => '总时间';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return '完成$category的第$level关解锁';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return '排列 $count 个$type $direction';
  }

  @override
  String get ascending => '升序';

  @override
  String get descending => '降序';

  @override
  String get multiplayer => '传递游戏';

  @override
  String get multiplayerSetup => '传递游戏设置';

  @override
  String get selectCategory => '选择类别';

  @override
  String get itemCount => '项目数量';

  @override
  String get playerCount => '玩家数量';

  @override
  String playerName(Object number) {
    return '玩家 $number 名字';
  }

  @override
  String get startGame => '开始游戏';

  @override
  String getReadyPlayer(Object name) {
    return '准备好，$name！';
  }

  @override
  String get yourTurn => '轮到你了';

  @override
  String get tapToStart => '点击开始';

  @override
  String get giveUp => '放弃';

  @override
  String get failed => '失败';

  @override
  String get failedNextPlayer => '失败！下一位...';

  @override
  String continueLeft(Object count) {
    return '继续（剩余$count次）';
  }

  @override
  String get draw => '平局！';

  @override
  String get everyoneGaveUp => '所有人都放弃了！';

  @override
  String get everyoneFailed => '所有人都失败了！';

  @override
  String get noOneCompleted => '没有人完成！';

  @override
  String get leaderboard => '排行榜';

  @override
  String get localMultiplayer => '传递游戏';

  @override
  String get players => '玩家';

  @override
  String get addPlayer => '添加玩家';

  @override
  String get removePlayer => '移除';

  @override
  String get category => '类别';

  @override
  String get ready => '准备好了？';

  @override
  String get go => '开始！';

  @override
  String get complete => '完成';

  @override
  String get unlocked => '已解锁';

  @override
  String get locked => '已锁定';

  @override
  String get secretAchievement => '秘密成就';

  @override
  String get dailyChallenges => '每日挑战';

  @override
  String get dailyCompleted => '每日已完成';

  @override
  String get perfectCompletions => '完美';

  @override
  String get multiplayerGames => '传递游戏';

  @override
  String get memoryProgress => '记忆进度';

  @override
  String get achFirstSteps => '第一步';

  @override
  String get achFirstStepsDesc => '完成你的第一关';

  @override
  String get achGettingStarted => '入门';

  @override
  String get achGettingStartedDesc => '完成10关';

  @override
  String get achOnARoll => '势如破竹';

  @override
  String get achOnARollDesc => '完成50关';

  @override
  String get achCenturyClub => '百关俱乐部';

  @override
  String get achCenturyClubDesc => '完成100关';

  @override
  String get achHalfwayThere => '半程达成';

  @override
  String get achHalfwayThereDesc => '完成500关';

  @override
  String get achSortingMaster => '排序大师';

  @override
  String get achSortingMasterDesc => '完成全部600关';

  @override
  String get achConsistent => '坚持不懈';

  @override
  String get achConsistentDesc => '连续玩3天';

  @override
  String get achWeekWarrior => '周冠军';

  @override
  String get achWeekWarriorDesc => '连续玩7天';

  @override
  String get achMonthlyMaster => '月度大师';

  @override
  String get achMonthlyMasterDesc => '连续玩30天';

  @override
  String get achLegendaryStreak => '传奇连胜';

  @override
  String get achLegendaryStreakDesc => '连续玩100天';

  @override
  String get achSpeedDemon => '速度恶魔';

  @override
  String get achSpeedDemonDesc => '5秒内完成关卡';

  @override
  String get achLightningFast => '闪电速度';

  @override
  String get achLightningFastDesc => '3秒内完成关卡';

  @override
  String get achBasicExpert => '基础专家';

  @override
  String get achBasicExpertDesc => '完成100个基础关卡';

  @override
  String get achFormatPro => '格式专家';

  @override
  String get achFormatProDesc => '完成100个格式关卡';

  @override
  String get achTimeLord => '时间之王';

  @override
  String get achTimeLordDesc => '完成100个时间关卡';

  @override
  String get achAlphabetizer => '字母专家';

  @override
  String get achAlphabetizerDesc => '完成100个名字关卡';

  @override
  String get achMixMaster => '混合大师';

  @override
  String get achMixMasterDesc => '完成100个混合关卡';

  @override
  String get achKnowledgeKing => '知识之王';

  @override
  String get achKnowledgeKingDesc => '完成100个知识关卡';

  @override
  String get achBasicPerfectionist => '基础完美主义者';

  @override
  String get achBasicPerfectionistDesc => '100%基础关卡';

  @override
  String get achFormatPerfectionist => '格式完美主义者';

  @override
  String get achFormatPerfectionistDesc => '100%格式关卡';

  @override
  String get achTimePerfectionist => '时间完美主义者';

  @override
  String get achTimePerfectionistDesc => '100%时间关卡';

  @override
  String get achNamesPerfectionist => '名字完美主义者';

  @override
  String get achNamesPerfectionistDesc => '100%名字关卡';

  @override
  String get achMixedPerfectionist => '混合完美主义者';

  @override
  String get achMixedPerfectionistDesc => '100%混合关卡';

  @override
  String get achKnowledgePerfectionist => '知识完美主义者';

  @override
  String get achKnowledgePerfectionistDesc => '100%知识关卡';

  @override
  String get achMemoryNovice => '记忆新手';

  @override
  String get achMemoryNoviceDesc => '10个记忆关卡';

  @override
  String get achMemoryExpert => '记忆专家';

  @override
  String get achMemoryExpertDesc => '50个记忆关卡';

  @override
  String get achMemoryMaster => '记忆大师';

  @override
  String get achMemoryMasterDesc => '100个记忆关卡';

  @override
  String get achPerfectRecall => '完美回忆';

  @override
  String get achPerfectRecallDesc => '5个完美记忆关卡';

  @override
  String get achMemoryPro => '记忆专家';

  @override
  String get achMemoryProDesc => '10个完美记忆关卡';

  @override
  String get achMemoryGenius => '记忆天才';

  @override
  String get achMemoryGeniusDesc => '25个完美记忆关卡';

  @override
  String get achEideticMemory => '照相记忆';

  @override
  String get achEideticMemoryDesc => '50个完美记忆关卡';

  @override
  String get achPhotographicMemory => '超强记忆';

  @override
  String get achPhotographicMemoryDesc => '100个完美记忆关卡';

  @override
  String get achMemoryBasicMaster => '记忆基础大师';

  @override
  String get achMemoryBasicMasterDesc => '记忆模式全部基础';

  @override
  String get achMemoryFormatMaster => '记忆格式大师';

  @override
  String get achMemoryFormatMasterDesc => '记忆模式全部格式';

  @override
  String get achMemoryTimeMaster => '记忆时间大师';

  @override
  String get achMemoryTimeMasterDesc => '记忆模式全部时间';

  @override
  String get achMemoryNamesMaster => '记忆名字大师';

  @override
  String get achMemoryNamesMasterDesc => '记忆模式全部名字';

  @override
  String get achMemoryMixedMaster => '记忆混合大师';

  @override
  String get achMemoryMixedMasterDesc => '记忆模式全部混合';

  @override
  String get achDailyStarter => '每日起步';

  @override
  String get achDailyStarterDesc => '第一次每日挑战';

  @override
  String get achWeeklyChallenger => '周挑战者';

  @override
  String get achWeeklyChallengerDesc => '7次每日挑战';

  @override
  String get achMonthlyChallenger => '月挑战者';

  @override
  String get achMonthlyChallengerDesc => '30次每日挑战';

  @override
  String get achDailyLegend => '每日传奇';

  @override
  String get achDailyLegendDesc => '100次每日挑战';

  @override
  String get achPerfectDay => '完美一天';

  @override
  String get achPerfectDayDesc => '5次完美每日';

  @override
  String get achPerfectWeek => '完美一周';

  @override
  String get achPerfectWeekDesc => '10次完美每日';

  @override
  String get achPerfectStreak => '完美连胜';

  @override
  String get achPerfectStreakDesc => '25次完美每日';

  @override
  String get achFlawlessPlayer => '完美玩家';

  @override
  String get achFlawlessPlayerDesc => '50次完美每日';

  @override
  String get achDailyPerfectionist => '每日完美主义者';

  @override
  String get achDailyPerfectionistDesc => '100次完美每日';

  @override
  String get achPartyHost => '派对主持人';

  @override
  String get achPartyHostDesc => '主持10场多人游戏';

  @override
  String get achSocialGamer => '社交玩家';

  @override
  String get achSocialGamerDesc => '主持25场多人游戏';

  @override
  String get achMultiplayerLegend => '多人传奇';

  @override
  String get achMultiplayerLegendDesc => '主持50场多人游戏';

  @override
  String get achPerfectRun => '完美通关';

  @override
  String get achPerfectRunDesc => '连续10关无失误';

  @override
  String get achDedicatedPlayer => '忠实玩家';

  @override
  String get achDedicatedPlayerDesc => '总共玩1小时';

  @override
  String get achMarathonRunner => '马拉松选手';

  @override
  String get achMarathonRunnerDesc => '总共玩5小时';

  @override
  String get achTotalMaster => '全能大师';

  @override
  String get achTotalMasterDesc => '1100关（普通+记忆）';

  @override
  String get achCompletionist => '完美主义者';

  @override
  String get achCompletionistDesc => '解锁所有成就';

  @override
  String get achNightOwl => '夜猫子';

  @override
  String get achNightOwlDesc => '在午夜到凌晨5点之间玩';

  @override
  String get achEarlyBird => '早起的鸟儿';

  @override
  String get achEarlyBirdDesc => '在凌晨5点到7点之间玩';

  @override
  String get achNewYearSorter => '新年排序者';

  @override
  String get achNewYearSorterDesc => '在1月1日玩';

  @override
  String get achNeverGiveUp => '永不放弃';

  @override
  String get achNeverGiveUpDesc => '使用重试50次';

  @override
  String get achInstantWin => '瞬间胜利';

  @override
  String get achInstantWinDesc => '2秒内完成';

  @override
  String get achDescendingFan => '降序爱好者';

  @override
  String get achDescendingFanDesc => '连续20次降序';

  @override
  String get achSwapMaster => '交换大师';

  @override
  String get achSwapMasterDesc => '仅用交换完成10关';

  @override
  String get achShiftMaster => '移动大师';

  @override
  String get achShiftMasterDesc => '仅用移动完成10关';

  @override
  String get watchAd => '观看广告获取额外机会';

  @override
  String get goPro => '升级专业版';

  @override
  String get noAds => '无广告';

  @override
  String get noAdsDesc => '移除所有横幅和插页广告';

  @override
  String get unlimitedAttempts => '无限尝试';

  @override
  String get unlimitedAttemptsDesc => '永不用完机会';

  @override
  String get proBadge => '专业徽章';

  @override
  String get proBadgeDesc => '展示你的高级身份';

  @override
  String get supportDev => '支持开发者';

  @override
  String get supportDevDesc => '帮助我们创作更多内容';

  @override
  String get whatYouGet => '你将获得';

  @override
  String get processing => '处理中...';

  @override
  String get purchaseSuccess => '欢迎加入专业版！';

  @override
  String get youAreNowPro => '你现在可以无限使用所有功能！';

  @override
  String get ok => '确定';

  @override
  String get restorePurchases => '恢复购买';

  @override
  String get noPurchasesToRestore => '未找到之前的购买记录';

  @override
  String get alreadyPro => '你已经是专业版用户！';
}
