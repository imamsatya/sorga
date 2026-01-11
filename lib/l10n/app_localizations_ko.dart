// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Sorga';

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
}
