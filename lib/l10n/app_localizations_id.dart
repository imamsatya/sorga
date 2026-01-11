// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Beranda';

  @override
  String get play => 'Main';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get statistics => 'Statistik';

  @override
  String get chooseCategory => 'Pilih Kategori';

  @override
  String levelCompleted(Object id) {
    return 'Level $id Selesai!';
  }

  @override
  String get sortItems => 'Urutkan Item';

  @override
  String get sortNames => 'Urutkan Nama';

  @override
  String get lowToHigh => 'Kecil → Besar';

  @override
  String get highToLow => 'Besar → Kecil';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Level Berikutnya';

  @override
  String get retry => 'Ulangi';

  @override
  String get dailyChallenge => 'Tantangan Harian';

  @override
  String get streak => 'Streak';

  @override
  String get perfect => 'SEMPURNA!';

  @override
  String get tryAgain => 'COBA LAGI';

  @override
  String get completed => 'selesai';

  @override
  String get basicNumbers => 'Angka Dasar';

  @override
  String get formattedNumbers => 'Format';

  @override
  String get timeFormats => 'Format Waktu';

  @override
  String get nameSorting => 'Urutkan Nama';

  @override
  String get mixedFormats => 'Format Campuran';

  @override
  String get knowledge => 'Pengetahuan';

  @override
  String get levels => 'level';

  @override
  String get share => 'Bagikan';

  @override
  String get close => 'Tutup';

  @override
  String get yourTime => 'WAKTU ANDA';

  @override
  String get continueGame => 'LANJUTKAN';

  @override
  String get retryLevel => 'ULANGI LEVEL';
}
