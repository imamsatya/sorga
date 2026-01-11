// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Inicio';

  @override
  String get play => 'Jugar';

  @override
  String get achievements => 'Logros';

  @override
  String get statistics => 'Estadísticas';

  @override
  String get chooseCategory => 'Elegir Categoría';

  @override
  String levelCompleted(Object id) {
    return '¡Nivel $id Completado!';
  }

  @override
  String get sortItems => 'Ordenar Items';

  @override
  String get sortNames => 'Ordenar Nombres';

  @override
  String get lowToHigh => 'Menor → Mayor';

  @override
  String get highToLow => 'Mayor → Menor';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Siguiente Nivel';

  @override
  String get retry => 'Reintentar';

  @override
  String get dailyChallenge => 'Desafío Diario';

  @override
  String get streak => 'Racha';

  @override
  String get perfect => '¡PERFECTO!';

  @override
  String get tryAgain => 'INTÉNTALO DE NUEVO';

  @override
  String get completed => 'completado';

  @override
  String get basicNumbers => 'Números Básicos';

  @override
  String get formattedNumbers => 'Formateados';

  @override
  String get timeFormats => 'Formatos de Tiempo';

  @override
  String get nameSorting => 'Ordenar Nombres';

  @override
  String get mixedFormats => 'Formatos Mixtos';

  @override
  String get knowledge => 'Conocimiento';

  @override
  String get levels => 'niveles';

  @override
  String get share => 'Compartir';

  @override
  String get close => 'Cerrar';

  @override
  String get yourTime => 'TU TIEMPO';

  @override
  String get continueGame => 'CONTINUAR';

  @override
  String get retryLevel => 'REINTENTAR NIVEL';
}
