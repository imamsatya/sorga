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

  @override
  String get yourSortingParadise => 'Tu Paraíso de Clasificación';

  @override
  String get done => 'Hecho';

  @override
  String get progress => 'Progreso';

  @override
  String get time => 'Tiempo';

  @override
  String get day => 'día';

  @override
  String get days => 'días';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get systemDefault => 'Predeterminado del Sistema';

  @override
  String get soundEffects => 'Efectos de Sonido';

  @override
  String get vibration => 'Vibración';

  @override
  String get check => 'Verificar';

  @override
  String get level => 'Nivel';

  @override
  String get items => 'elementos';

  @override
  String get sortAscending => 'Ordenar ASC';

  @override
  String get sortDescending => 'Ordenar DESC';

  @override
  String get best => 'Mejor';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return 'Ordenar $count $type $direction';
  }

  @override
  String get playAgain => 'Jugar de Nuevo';

  @override
  String get startChallenge => 'INICIAR DESAFÍO';

  @override
  String get completedToday => '¡Completado Hoy!';

  @override
  String get comeBackTomorrow => 'Vuelve mañana para un nuevo desafío';

  @override
  String get shareResult => 'Compartir Resultado';

  @override
  String get shareAchievement => 'Compartir Logro';

  @override
  String get canYouBeatMyTime => '¿Puedes superar mi tiempo?';

  @override
  String get dailyStreak => 'Racha Diaria';

  @override
  String get dailyStreakActive => '¡Racha Diaria Activa!';

  @override
  String get categoryProgress => 'Progreso de Categoría';

  @override
  String get completedLevels => 'Niveles Completados';

  @override
  String get currentStreak => 'Racha Actual';

  @override
  String get longestStreak => 'Racha Más Larga';

  @override
  String get totalPlayTime => 'Tiempo Total de Juego';

  @override
  String get totalAttempts => 'Intentos Totales';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get statisticsTitle => 'Estadísticas';

  @override
  String get selectLevel => 'Seleccionar Nivel';

  @override
  String get about => 'Acerca de';

  @override
  String get appDescription => 'Sorga - Un Juego de Ordenar';

  @override
  String get version => 'Versión';

  @override
  String get levelsDescription =>
      '800 niveles en 6 categorías. ¡Entrena tu cerebro con números, tiempo, nombres y más!';

  @override
  String get dragAndDrop => 'Arrastrar y Soltar';

  @override
  String get dragItemsDescription =>
      'Arrastra los elementos para reordenarlos en el orden correcto';

  @override
  String get skip => 'Omitir';

  @override
  String get next => 'SIGUIENTE';

  @override
  String get shift => 'Desplazar';

  @override
  String get swap => 'Intercambiar';

  @override
  String get reset => 'Reiniciar';

  @override
  String get daily => 'Diario';

  @override
  String get orderNotRight => 'El orden no es correcto.';

  @override
  String chancesLeft(Object count) {
    return '¡Te quedan $count oportunidad(es)!';
  }

  @override
  String get sort => 'Ordenar';

  @override
  String get asc => 'ASC';

  @override
  String get desc => 'DESC';

  @override
  String get thursday => 'Jueves';

  @override
  String get friday => 'Viernes';

  @override
  String get saturday => 'Sábado';

  @override
  String get sunday => 'Domingo';

  @override
  String get monday => 'Lunes';

  @override
  String get tuesday => 'Martes';

  @override
  String get wednesday => 'Miércoles';

  @override
  String get getReady => '¡Prepárate!';

  @override
  String get attempt => 'Intento';

  @override
  String get noMoreChances => '¡No hay más oportunidades. Inténtalo de nuevo!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y completado';
  }

  @override
  String get sortTheItems => 'Ordena los elementos';

  @override
  String get tapCheckWhenDone => 'Toca Verificar cuando termines.';

  @override
  String get useDragMode => 'Usa modo Desplazar o Intercambiar';

  @override
  String get shiftModeDescription =>
      'El modo Desplazar desliza elementos. El modo Intercambiar cambia posiciones.';

  @override
  String get youreReady => '¡Estás listo!';

  @override
  String get startSorting => '¡Comienza a ordenar y supera tu mejor tiempo!';

  @override
  String get bestTime => 'Mejor Tiempo';

  @override
  String get attempts => 'Intentos';

  @override
  String get iCompletedLevel =>
      '¡Acabo de completar este nivel en Sorga! ¿Puedes superar mi tiempo?';

  @override
  String get dailyChallengeShare => '🎯 Sorga Desafío Diario';

  @override
  String get shiftAndSwap => 'Desplazar & Intercambiar';

  @override
  String get shiftAndSwapDescription =>
      'Usa el modo DESPLAZAR para mover elementos paso a paso, o INTERCAMBIAR para cambiar posiciones';

  @override
  String get checkAnswer => 'Verificar Respuesta';

  @override
  String get checkAnswerDescription =>
      'Cuando estés listo, toca VERIFICAR para comprobar tu respuesta. ¡Buena suerte!';

  @override
  String get startPlaying => 'COMENZAR A JUGAR';

  @override
  String get january => 'Enero';

  @override
  String get february => 'Febrero';

  @override
  String get march => 'Marzo';

  @override
  String get april => 'Abril';

  @override
  String get may => 'Mayo';

  @override
  String get june => 'Junio';

  @override
  String get july => 'Julio';

  @override
  String get august => 'Agosto';

  @override
  String get september => 'Septiembre';

  @override
  String get october => 'Octubre';

  @override
  String get november => 'Noviembre';

  @override
  String get december => 'Diciembre';

  @override
  String get numbers => 'números';

  @override
  String get times => 'tiempos';

  @override
  String get names => 'nombres';

  @override
  String get memorized => '¡Lo Memoricé!';

  @override
  String get memoryMode => 'Memoria';

  @override
  String get memorizeTime => 'Memorizar';

  @override
  String get sortTime => 'Ordenar';

  @override
  String get totalTime => 'Tiempo Total';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return 'Completa el Nivel $level en $category para desbloquear';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return 'Ordenar $count $type $direction';
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
  String get leaderboard => 'Leaderboard';
}
