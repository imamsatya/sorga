// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'SORTIQ';

  @override
  String get home => '홈';

  @override
  String get play => '플레이';

  @override
  String get achievements => '업적';

  @override
  String get statistics => '통계';

  @override
  String get chooseCategory => '카테고리 선택';

  @override
  String levelCompleted(Object id) {
    return '레벨 $id 완료!';
  }

  @override
  String get sortItems => '아이템 정렬';

  @override
  String get sortNames => '이름 정렬';

  @override
  String get lowToHigh => '작은 → 큰';

  @override
  String get highToLow => '큰 → 작은';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => '다음 레벨';

  @override
  String get retry => '다시하기';

  @override
  String get dailyChallenge => '일일 챌린지';

  @override
  String get streak => '연속 기록';

  @override
  String get perfect => '완벽!';

  @override
  String get tryAgain => '다시 시도';

  @override
  String get completed => '완료';

  @override
  String get basicNumbers => '기본 숫자';

  @override
  String get formattedNumbers => '포맷';

  @override
  String get timeFormats => '시간 형식';

  @override
  String get nameSorting => '이름 정렬';

  @override
  String get mixedFormats => '혼합 형식';

  @override
  String get knowledge => '지식';

  @override
  String get levels => '레벨';

  @override
  String get share => '공유';

  @override
  String get close => '닫기';

  @override
  String get yourTime => '당신의 시간';

  @override
  String get continueGame => '계속하기';

  @override
  String get retryLevel => '레벨 재시도';

  @override
  String get yourSortingParadise => '당신의 정렬 천국';

  @override
  String get done => '완료';

  @override
  String get progress => '진행';

  @override
  String get time => '시간';

  @override
  String get day => '일';

  @override
  String get days => '일';

  @override
  String get settings => '설정';

  @override
  String get language => '언어';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get soundEffects => '효과음';

  @override
  String get vibration => '진동';

  @override
  String get check => '확인';

  @override
  String get level => '레벨';

  @override
  String get items => '항목';

  @override
  String get sortAscending => '오름차순';

  @override
  String get sortDescending => '내림차순';

  @override
  String get best => '최고';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return '$count개의 $type을 $direction으로 정렬';
  }

  @override
  String get playAgain => '다시 플레이';

  @override
  String get startChallenge => '챌린지 시작';

  @override
  String get completedToday => '오늘 완료!';

  @override
  String get comeBackTomorrow => '내일 새로운 챌린지를 위해 돌아오세요';

  @override
  String get shareResult => '결과 공유';

  @override
  String get shareAchievement => '업적 공유';

  @override
  String get canYouBeatMyTime => '내 기록을 이길 수 있나요?';

  @override
  String get dailyStreak => '일일 연속';

  @override
  String get dailyStreakActive => '일일 연속 진행 중!';

  @override
  String get categoryProgress => '카테고리 진행';

  @override
  String get completedLevels => '완료된 레벨';

  @override
  String get currentStreak => '현재 연속 일수';

  @override
  String get longestStreak => '최장 연속 일수';

  @override
  String get totalPlayTime => '총 플레이 시간';

  @override
  String get totalAttempts => '총 시도 횟수';

  @override
  String get achievementsTitle => '업적';

  @override
  String get statisticsTitle => '통계';

  @override
  String get selectLevel => '레벨 선택';

  @override
  String get about => '정보';

  @override
  String get appDescription => 'SORTIQ - 당신의 두뇌는 얼마나 빠른가요?';

  @override
  String get version => '버전';

  @override
  String get levelsDescription =>
      '11개 카테고리에 1100개 레벨. 숫자, 시간, 이름 등으로 두뇌를 훈련하세요!';

  @override
  String get dragAndDrop => '드래그 앤 드롭';

  @override
  String get dragItemsDescription => '아이템을 드래그하여 올바른 순서로 재배열하세요';

  @override
  String get skip => '건너뛰기';

  @override
  String get next => '다음';

  @override
  String get shift => '이동';

  @override
  String get swap => '교환';

  @override
  String get reset => '초기화';

  @override
  String get daily => '일일';

  @override
  String get orderNotRight => '순서가 맞지 않습니다.';

  @override
  String chancesLeft(Object count) {
    return '$count번의 기회가 남았습니다!';
  }

  @override
  String get sort => '정렬';

  @override
  String get asc => '오름차순';

  @override
  String get desc => '내림차순';

  @override
  String get thursday => '목요일';

  @override
  String get friday => '금요일';

  @override
  String get saturday => '토요일';

  @override
  String get sunday => '일요일';

  @override
  String get monday => '월요일';

  @override
  String get tuesday => '화요일';

  @override
  String get wednesday => '수요일';

  @override
  String get getReady => '준비하세요!';

  @override
  String get attempt => '시도';

  @override
  String get noMoreChances => '기회가 없습니다. 다시 시도하세요!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y 완료';
  }

  @override
  String get sortTheItems => '아이템 정렬하기';

  @override
  String get tapCheckWhenDone => '완료되면 확인을 탭하세요.';

  @override
  String get useDragMode => '이동 또는 교환 모드 사용';

  @override
  String get shiftModeDescription => '이동 모드는 아이템을 밀어요. 교환 모드는 위치를 바꿔요.';

  @override
  String get youreReady => '준비됐어요!';

  @override
  String get startSorting => '정렬을 시작하고 최고 기록을 경신하세요!';

  @override
  String get bestTime => '최고 기록';

  @override
  String get attempts => '시도 횟수';

  @override
  String get iCompletedLevel => 'SORTIQ에서 이 레벨을 클리어했어요! 내 기록을 깰 수 있을까요?';

  @override
  String get dailyChallengeShare => '🎯 SORTIQ 일일 챌린지';

  @override
  String get shiftAndSwap => '이동 & 교환';

  @override
  String get shiftAndSwapDescription => '이동 모드로 한 단계씩 이동하거나, 교환으로 위치를 바꾸세요';

  @override
  String get checkAnswer => '정답 확인';

  @override
  String get checkAnswerDescription => '준비되면 확인을 탭하여 정답을 확인하세요. 행운을 빕니다!';

  @override
  String get startPlaying => '플레이 시작';

  @override
  String get january => '1월';

  @override
  String get february => '2월';

  @override
  String get march => '3월';

  @override
  String get april => '4월';

  @override
  String get may => '5월';

  @override
  String get june => '6월';

  @override
  String get july => '7월';

  @override
  String get august => '8월';

  @override
  String get september => '9월';

  @override
  String get october => '10월';

  @override
  String get november => '11월';

  @override
  String get december => '12월';

  @override
  String get numbers => '숫자';

  @override
  String get times => '시간';

  @override
  String get names => '이름';

  @override
  String get memorized => '외웠어요!';

  @override
  String get memoryMode => '기억';

  @override
  String get memorizeTime => '암기';

  @override
  String get sortTime => '정렬';

  @override
  String get totalTime => '총 시간';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return '$category의 레벨 $level을 완료하여 잠금 해제';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return '$count개의 $type을 $direction으로 정렬';
  }

  @override
  String get ascending => '오름차순';

  @override
  String get descending => '내림차순';

  @override
  String get multiplayer => '멀티플레이어';

  @override
  String get multiplayerSetup => '멀티플레이어 설정';

  @override
  String get selectCategory => '카테고리 선택';

  @override
  String get itemCount => '아이템 수';

  @override
  String get playerCount => '플레이어 수';

  @override
  String playerName(Object number) {
    return '플레이어 $number 이름';
  }

  @override
  String get startGame => '게임 시작';

  @override
  String getReadyPlayer(Object name) {
    return '$name님, 준비!';
  }

  @override
  String get yourTurn => '당신의 차례입니다!';

  @override
  String get tapToStart => '탭하여 시작';

  @override
  String get giveUp => '포기';

  @override
  String get failed => '실패';

  @override
  String get failedNextPlayer => '실패! 다음...';

  @override
  String continueLeft(Object count) {
    return '계속 ($count회 남음)';
  }

  @override
  String get draw => '무승부!';

  @override
  String get everyoneGaveUp => '모두 포기했습니다!';

  @override
  String get everyoneFailed => '모두 실패했습니다!';

  @override
  String get noOneCompleted => '아무도 완료하지 못했습니다!';

  @override
  String get leaderboard => '리더보드';

  @override
  String get localMultiplayer => '로컬 멀티플레이어';

  @override
  String get players => '플레이어';

  @override
  String get addPlayer => '플레이어 추가';

  @override
  String get removePlayer => '삭제';

  @override
  String get category => '카테고리';

  @override
  String get ready => '준비?';

  @override
  String get go => '시작!';

  @override
  String get complete => '완료';

  @override
  String get unlocked => '잠금 해제';

  @override
  String get locked => '잠김';

  @override
  String get secretAchievement => '비밀 업적';

  @override
  String get dailyChallenges => '일일 도전';

  @override
  String get dailyCompleted => '완료 횟수';

  @override
  String get perfectCompletions => '퍼펙트';

  @override
  String get multiplayerGames => '멀티플레이어';

  @override
  String get memoryProgress => '메모리 진행';

  @override
  String get achFirstSteps => '첫 걸음';

  @override
  String get achFirstStepsDesc => '첫 레벨 완료';

  @override
  String get achGettingStarted => '시작하기';

  @override
  String get achGettingStartedDesc => '10레벨 완료';

  @override
  String get achOnARoll => '순풍에 돛';

  @override
  String get achOnARollDesc => '50레벨 완료';

  @override
  String get achCenturyClub => '100 클럽';

  @override
  String get achCenturyClubDesc => '100레벨 완료';

  @override
  String get achHalfwayThere => '절반 완료';

  @override
  String get achHalfwayThereDesc => '500레벨 완료';

  @override
  String get achSortingMaster => '정렬 마스터';

  @override
  String get achSortingMasterDesc => '600레벨 모두 완료';

  @override
  String get achConsistent => '꾸준함';

  @override
  String get achConsistentDesc => '3일 연속 플레이';

  @override
  String get achWeekWarrior => '주간 전사';

  @override
  String get achWeekWarriorDesc => '7일 연속 플레이';

  @override
  String get achMonthlyMaster => '월간 마스터';

  @override
  String get achMonthlyMasterDesc => '30일 연속 플레이';

  @override
  String get achLegendaryStreak => '전설의 연속';

  @override
  String get achLegendaryStreakDesc => '100일 연속 플레이';

  @override
  String get achSpeedDemon => '스피드 악마';

  @override
  String get achSpeedDemonDesc => '5초 이내 완료';

  @override
  String get achLightningFast => '번개처럼';

  @override
  String get achLightningFastDesc => '3초 이내 완료';

  @override
  String get achBasicExpert => '기본 전문가';

  @override
  String get achBasicExpertDesc => '기본 100레벨';

  @override
  String get achFormatPro => '형식 프로';

  @override
  String get achFormatProDesc => '형식 100레벨';

  @override
  String get achTimeLord => '시간의 지배자';

  @override
  String get achTimeLordDesc => '시간 100레벨';

  @override
  String get achAlphabetizer => '이름 달인';

  @override
  String get achAlphabetizerDesc => '이름 100레벨';

  @override
  String get achMixMaster => '믹스 마스터';

  @override
  String get achMixMasterDesc => '혼합 100레벨';

  @override
  String get achKnowledgeKing => '지식의 왕';

  @override
  String get achKnowledgeKingDesc => '지식 100레벨';

  @override
  String get achBasicPerfectionist => '기본 완벽주의';

  @override
  String get achBasicPerfectionistDesc => '기본 100% 완료';

  @override
  String get achFormatPerfectionist => '형식 완벽주의';

  @override
  String get achFormatPerfectionistDesc => '형식 100% 완료';

  @override
  String get achTimePerfectionist => '시간 완벽주의';

  @override
  String get achTimePerfectionistDesc => '시간 100% 완료';

  @override
  String get achNamesPerfectionist => '이름 완벽주의';

  @override
  String get achNamesPerfectionistDesc => '이름 100% 완료';

  @override
  String get achMixedPerfectionist => '혼합 완벽주의';

  @override
  String get achMixedPerfectionistDesc => '혼합 100% 완료';

  @override
  String get achKnowledgePerfectionist => '지식 완벽주의';

  @override
  String get achKnowledgePerfectionistDesc => '지식 100% 완료';

  @override
  String get achMemoryNovice => '메모리 초보자';

  @override
  String get achMemoryNoviceDesc => '메모리 10레벨';

  @override
  String get achMemoryExpert => '메모리 전문가';

  @override
  String get achMemoryExpertDesc => '메모리 50레벨';

  @override
  String get achMemoryMaster => '메모리 마스터';

  @override
  String get achMemoryMasterDesc => '메모리 100레벨';

  @override
  String get achPerfectRecall => '완벽한 기억';

  @override
  String get achPerfectRecallDesc => '메모리 5회 노미스';

  @override
  String get achMemoryPro => '메모리 프로';

  @override
  String get achMemoryProDesc => '메모리 10회 노미스';

  @override
  String get achMemoryGenius => '메모리 천재';

  @override
  String get achMemoryGeniusDesc => '메모리 25회 노미스';

  @override
  String get achEideticMemory => '직관기억';

  @override
  String get achEideticMemoryDesc => '메모리 50회 노미스';

  @override
  String get achPhotographicMemory => '사진기억';

  @override
  String get achPhotographicMemoryDesc => '메모리 100회 노미스';

  @override
  String get achMemoryBasicMaster => '메모리 기본 마스터';

  @override
  String get achMemoryBasicMasterDesc => '메모리에서 기본 모두';

  @override
  String get achMemoryFormatMaster => '메모리 형식 마스터';

  @override
  String get achMemoryFormatMasterDesc => '메모리에서 형식 모두';

  @override
  String get achMemoryTimeMaster => '메모리 시간 마스터';

  @override
  String get achMemoryTimeMasterDesc => '메모리에서 시간 모두';

  @override
  String get achMemoryNamesMaster => '메모리 이름 마스터';

  @override
  String get achMemoryNamesMasterDesc => '메모리에서 이름 모두';

  @override
  String get achMemoryMixedMaster => '메모리 혼합 마스터';

  @override
  String get achMemoryMixedMasterDesc => '메모리에서 혼합 모두';

  @override
  String get achDailyStarter => '일일 시작';

  @override
  String get achDailyStarterDesc => '첫 일일 도전';

  @override
  String get achWeeklyChallenger => '주간 도전자';

  @override
  String get achWeeklyChallengerDesc => '일일 도전 7회';

  @override
  String get achMonthlyChallenger => '월간 도전자';

  @override
  String get achMonthlyChallengerDesc => '일일 도전 30회';

  @override
  String get achDailyLegend => '일일 레전드';

  @override
  String get achDailyLegendDesc => '일일 도전 100회';

  @override
  String get achPerfectDay => '완벽한 하루';

  @override
  String get achPerfectDayDesc => '일일 5회 노미스';

  @override
  String get achPerfectWeek => '완벽한 주';

  @override
  String get achPerfectWeekDesc => '일일 10회 노미스';

  @override
  String get achPerfectStreak => '완벽한 연속';

  @override
  String get achPerfectStreakDesc => '일일 25회 노미스';

  @override
  String get achFlawlessPlayer => '흠없는 플레이어';

  @override
  String get achFlawlessPlayerDesc => '일일 50회 노미스';

  @override
  String get achDailyPerfectionist => '일일 완벽주의';

  @override
  String get achDailyPerfectionistDesc => '일일 100회 노미스';

  @override
  String get achPartyHost => '파티 호스트';

  @override
  String get achPartyHostDesc => '멀티 10게임';

  @override
  String get achSocialGamer => '소셜 게이머';

  @override
  String get achSocialGamerDesc => '멀티 25게임';

  @override
  String get achMultiplayerLegend => '멀티 레전드';

  @override
  String get achMultiplayerLegendDesc => '멀티 50게임';

  @override
  String get achPerfectRun => '완벽한 달리기';

  @override
  String get achPerfectRunDesc => '10레벨 연속 노미스';

  @override
  String get achDedicatedPlayer => '헌신적인 플레이어';

  @override
  String get achDedicatedPlayerDesc => '총 1시간 플레이';

  @override
  String get achMarathonRunner => '마라톤 러너';

  @override
  String get achMarathonRunnerDesc => '총 5시간 플레이';

  @override
  String get achTotalMaster => '토탈 마스터';

  @override
  String get achTotalMasterDesc => '1100레벨 달성';

  @override
  String get achCompletionist => '완성주의자';

  @override
  String get achCompletionistDesc => '모든 업적 해제';

  @override
  String get achNightOwl => '올빼미족';

  @override
  String get achNightOwlDesc => '자정~새벽5시 플레이';

  @override
  String get achEarlyBird => '얼리버드';

  @override
  String get achEarlyBirdDesc => '새벽5시~7시 플레이';

  @override
  String get achNewYearSorter => '새해 정렬러';

  @override
  String get achNewYearSorterDesc => '1월 1일에 플레이';

  @override
  String get achNeverGiveUp => '포기하지 않기';

  @override
  String get achNeverGiveUpDesc => '재시도 50회 사용';

  @override
  String get achInstantWin => '즉시 승리';

  @override
  String get achInstantWinDesc => '2초 이내 완료';

  @override
  String get achDescendingFan => '내림차순 팬';

  @override
  String get achDescendingFanDesc => '내림차순 20연속';

  @override
  String get achSwapMaster => '스왑 마스터';

  @override
  String get achSwapMasterDesc => '스왑만으로 10레벨';

  @override
  String get achShiftMaster => '시프트 마스터';

  @override
  String get achShiftMasterDesc => '시프트만으로 10레벨';

  @override
  String get watchAd => '광고 보고 추가 기회';

  @override
  String get goPro => '프로 버전';

  @override
  String get noAds => '광고 없음';

  @override
  String get noAdsDesc => '모든 배너 및 전면 광고 제거';

  @override
  String get unlimitedAttempts => '무제한 시도';

  @override
  String get unlimitedAttemptsDesc => '기회가 절대 끊기지 않습니다';

  @override
  String get proBadge => '프로 배지';

  @override
  String get proBadgeDesc => '프리미엄 상태 표시';

  @override
  String get supportDev => '개발자 지원';

  @override
  String get supportDevDesc => '더 많은 콘텐츠 제작에 도움을 주세요';

  @override
  String get whatYouGet => '제공 내용';

  @override
  String get processing => '처리 중...';

  @override
  String get purchaseSuccess => '프로에 오신 것을 환영합니다!';

  @override
  String get youAreNowPro => '이제 모든 기능에 무제한으로 액세스할 수 있습니다!';

  @override
  String get ok => '확인';

  @override
  String get restorePurchases => '구매 복원';

  @override
  String get noPurchasesToRestore => '이전 구매를 찾을 수 없습니다';

  @override
  String get alreadyPro => '이미 프로입니다!';
}
