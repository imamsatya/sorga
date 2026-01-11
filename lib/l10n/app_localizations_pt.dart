// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Início';

  @override
  String get play => 'Jogar';

  @override
  String get achievements => 'Conquistas';

  @override
  String get statistics => 'Estatísticas';

  @override
  String get chooseCategory => 'Escolher Categoria';

  @override
  String levelCompleted(Object id) {
    return 'Nível $id Concluído!';
  }

  @override
  String get sortItems => 'Ordenar Itens';

  @override
  String get sortNames => 'Ordenar Nomes';

  @override
  String get lowToHigh => 'Menor → Maior';

  @override
  String get highToLow => 'Maior → Menor';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Próximo Nível';

  @override
  String get retry => 'Tentar Novamente';

  @override
  String get dailyChallenge => 'Desafio Diário';

  @override
  String get streak => 'Sequência';

  @override
  String get perfect => 'PERFEITO!';

  @override
  String get tryAgain => 'TENTE NOVAMENTE';

  @override
  String get completed => 'concluído';

  @override
  String get basicNumbers => 'Números Básicos';

  @override
  String get formattedNumbers => 'Formatados';

  @override
  String get timeFormats => 'Formatos de Tempo';

  @override
  String get nameSorting => 'Ordenar Nomes';

  @override
  String get mixedFormats => 'Formatos Mistos';

  @override
  String get knowledge => 'Conhecimento';

  @override
  String get levels => 'níveis';

  @override
  String get share => 'Compartilhar';

  @override
  String get close => 'Fechar';

  @override
  String get yourTime => 'SEU TEMPO';

  @override
  String get continueGame => 'CONTINUAR';

  @override
  String get retryLevel => 'TENTAR NÍVEL';
}
