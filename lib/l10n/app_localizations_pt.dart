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

  @override
  String get yourSortingParadise => 'Seu Paraíso de Ordenação';

  @override
  String get done => 'Concluído';

  @override
  String get progress => 'Progresso';

  @override
  String get time => 'Tempo';

  @override
  String get day => 'dia';

  @override
  String get days => 'dias';

  @override
  String get settings => 'Configurações';

  @override
  String get language => 'Idioma';

  @override
  String get systemDefault => 'Padrão do Sistema';

  @override
  String get soundEffects => 'Efeitos Sonoros';

  @override
  String get vibration => 'Vibração';

  @override
  String get check => 'Verificar';

  @override
  String get level => 'Nível';

  @override
  String get items => 'itens';

  @override
  String get sortAscending => 'Ordenar ASC';

  @override
  String get sortDescending => 'Ordenar DESC';

  @override
  String get best => 'Melhor';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return 'Ordenar $count $type $direction';
  }

  @override
  String get playAgain => 'Jogar Novamente';

  @override
  String get startChallenge => 'INICIAR DESAFIO';

  @override
  String get completedToday => 'Concluído Hoje!';

  @override
  String get comeBackTomorrow => 'Volte amanhã para um novo desafio';

  @override
  String get shareResult => 'Compartilhar Resultado';

  @override
  String get shareAchievement => 'Compartilhar Conquista';

  @override
  String get canYouBeatMyTime => 'Você consegue superar meu tempo?';

  @override
  String get dailyStreak => 'Sequência Diária';

  @override
  String get dailyStreakActive => 'Sequência Diária Ativa!';

  @override
  String get categoryProgress => 'Progresso da Categoria';

  @override
  String get completedLevels => 'Níveis Concluídos';

  @override
  String get currentStreak => 'Sequência Atual';

  @override
  String get longestStreak => 'Maior Sequência';

  @override
  String get totalPlayTime => 'Tempo Total de Jogo';

  @override
  String get totalAttempts => 'Tentativas Totais';

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String get statisticsTitle => 'Estatísticas';

  @override
  String get selectLevel => 'Selecionar Nível';

  @override
  String get about => 'Sobre';

  @override
  String get appDescription => 'Sorga - Um Jogo de Ordenar';

  @override
  String get version => 'Versão';

  @override
  String get levelsDescription =>
      '800 níveis em 6 categorias. Treine seu cérebro com números, tempo, nomes e mais!';

  @override
  String get dragAndDrop => 'Arrastar e Soltar';

  @override
  String get dragItemsDescription =>
      'Arraste os itens para reorganizá-los na ordem correta';

  @override
  String get skip => 'Pular';

  @override
  String get next => 'PRÓXIMO';

  @override
  String get shift => 'Deslocar';

  @override
  String get swap => 'Trocar';

  @override
  String get reset => 'Reiniciar';

  @override
  String get daily => 'Diário';

  @override
  String get orderNotRight => 'A ordem não está correta.';

  @override
  String chancesLeft(Object count) {
    return 'Você tem $count chance(s) restante(s)!';
  }

  @override
  String get sort => 'Ordenar';

  @override
  String get asc => 'ASC';

  @override
  String get desc => 'DESC';

  @override
  String get thursday => 'Quinta-feira';

  @override
  String get friday => 'Sexta-feira';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get monday => 'Segunda-feira';

  @override
  String get tuesday => 'Terça-feira';

  @override
  String get wednesday => 'Quarta-feira';

  @override
  String get getReady => 'Preparar!';

  @override
  String get attempt => 'Tentativa';

  @override
  String get noMoreChances => 'Não há mais chances. Tente novamente!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y concluído';
  }

  @override
  String get sortTheItems => 'Ordene os itens';

  @override
  String get tapCheckWhenDone => 'Toque em Verificar quando terminar.';

  @override
  String get useDragMode => 'Use o modo Deslocar ou Trocar';

  @override
  String get shiftModeDescription =>
      'O modo Deslocar desliza itens. O modo Trocar troca posições.';

  @override
  String get youreReady => 'Você está pronto!';

  @override
  String get startSorting => 'Comece a ordenar e supere seu melhor tempo!';

  @override
  String get bestTime => 'Melhor Tempo';

  @override
  String get attempts => 'Tentativas';

  @override
  String get iCompletedLevel =>
      'Acabei de completar este nível no Sorga! Você consegue bater meu tempo?';

  @override
  String get dailyChallengeShare => '🎯 Sorga Desafio Diário';

  @override
  String get shiftAndSwap => 'Deslocar & Trocar';

  @override
  String get shiftAndSwapDescription =>
      'Use o modo DESLOCAR para mover itens passo a passo, ou TROCAR para trocar posições';

  @override
  String get checkAnswer => 'Verificar Resposta';

  @override
  String get checkAnswerDescription =>
      'Quando estiver pronto, toque em VERIFICAR para conferir sua resposta. Boa sorte!';

  @override
  String get startPlaying => 'COMEÇAR A JOGAR';

  @override
  String get january => 'Janeiro';

  @override
  String get february => 'Fevereiro';

  @override
  String get march => 'Março';

  @override
  String get april => 'Abril';

  @override
  String get may => 'Maio';

  @override
  String get june => 'Junho';

  @override
  String get july => 'Julho';

  @override
  String get august => 'Agosto';

  @override
  String get september => 'Setembro';

  @override
  String get october => 'Outubro';

  @override
  String get november => 'Novembro';

  @override
  String get december => 'Dezembro';

  @override
  String get numbers => 'números';

  @override
  String get times => 'tempos';

  @override
  String get names => 'nomes';
}
