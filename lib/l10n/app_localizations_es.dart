// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'SORTIQ';

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
  String get longestStreak => 'Mayor Racha';

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
  String get appDescription => 'SORTIQ - ¿Qué tan rápido es tu cerebro?';

  @override
  String get version => 'Versión';

  @override
  String get levelsDescription =>
      '1100 niveles en 11 categorías. ¡Entrena tu cerebro con números, tiempo, nombres y más!';

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
      '¡Acabo de completar este nivel en SORTIQ! ¿Puedes superar mi tiempo?';

  @override
  String get dailyChallengeShare => '🎯 SORTIQ Desafío Diario';

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
  String get names => 'Nombres';

  @override
  String get imReady => 'Estoy Listo 👁️';

  @override
  String get timeUp => '¡Se acabó el tiempo!';

  @override
  String get tapReadyToReveal => 'Toca \"Estoy Listo\" para revelar los items';

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
  String get multiplayer => 'Multijugador';

  @override
  String get multiplayerSetup => 'Configuración Multijugador';

  @override
  String get selectCategory => 'Seleccionar categoría';

  @override
  String get itemCount => 'Cantidad';

  @override
  String get playerCount => 'Número de jugadores';

  @override
  String playerName(Object number) {
    return 'Nombre del jugador $number';
  }

  @override
  String get startGame => 'Iniciar juego';

  @override
  String getReadyPlayer(Object name) {
    return '¡$name, prepárate!';
  }

  @override
  String get yourTurn => '¡Es tu turno!';

  @override
  String get tapToStart => 'Toca para empezar';

  @override
  String get giveUp => 'Rendirse';

  @override
  String get failed => 'Fallido';

  @override
  String get failedNextPlayer => '¡Fallido! Siguiente...';

  @override
  String continueLeft(Object count) {
    return 'Continuar ($count restantes)';
  }

  @override
  String get draw => '¡Empate!';

  @override
  String get everyoneGaveUp => '¡Todos se rindieron!';

  @override
  String get everyoneFailed => '¡Todos fallaron!';

  @override
  String get noOneCompleted => '¡Nadie lo completó!';

  @override
  String get leaderboard => 'Tabla de posiciones';

  @override
  String get localMultiplayer => 'Multijugador local';

  @override
  String get players => 'Jugadores';

  @override
  String get addPlayer => 'Añadir jugador';

  @override
  String get removePlayer => 'Eliminar';

  @override
  String get category => 'Categoría';

  @override
  String get ready => '¿Listo?';

  @override
  String get go => '¡YA!';

  @override
  String get complete => 'completo';

  @override
  String get unlocked => 'desbloqueado';

  @override
  String get locked => 'Bloqueado';

  @override
  String get secretAchievement => 'Logro secreto';

  @override
  String get dailyChallenges => 'Desafíos Diarios';

  @override
  String get dailyCompleted => 'Completados';

  @override
  String get perfectCompletions => 'Perfecto';

  @override
  String get multiplayerGames => 'Multijugador';

  @override
  String get memoryProgress => 'Progreso Memoria';

  @override
  String get achFirstSteps => 'Primeros Pasos';

  @override
  String get achFirstStepsDesc => 'Completa tu primer nivel';

  @override
  String get achGettingStarted => 'Empezando';

  @override
  String get achGettingStartedDesc => 'Completa 10 niveles';

  @override
  String get achOnARoll => 'En Racha';

  @override
  String get achOnARollDesc => 'Completa 50 niveles';

  @override
  String get achCenturyClub => 'Club del 100';

  @override
  String get achCenturyClubDesc => 'Completa 100 niveles';

  @override
  String get achHalfwayThere => 'A Mitad de Camino';

  @override
  String get achHalfwayThereDesc => 'Completa 500 niveles';

  @override
  String get achSortingMaster => 'Maestro Ordenador';

  @override
  String get achSortingMasterDesc => 'Completa los 600 niveles';

  @override
  String get achConsistent => 'Constante';

  @override
  String get achConsistentDesc => 'Juega 3 días seguidos';

  @override
  String get achWeekWarrior => 'Guerrero Semanal';

  @override
  String get achWeekWarriorDesc => 'Juega 7 días seguidos';

  @override
  String get achMonthlyMaster => 'Maestro Mensual';

  @override
  String get achMonthlyMasterDesc => 'Juega 30 días seguidos';

  @override
  String get achLegendaryStreak => 'Racha Legendaria';

  @override
  String get achLegendaryStreakDesc => 'Juega 100 días seguidos';

  @override
  String get achSpeedDemon => 'Demonio Veloz';

  @override
  String get achSpeedDemonDesc => 'Nivel en menos de 5s';

  @override
  String get achLightningFast => 'Rápido como Rayo';

  @override
  String get achLightningFastDesc => 'Nivel en menos de 3s';

  @override
  String get achBasicExpert => 'Experto Básico';

  @override
  String get achBasicExpertDesc => '100 niveles básicos';

  @override
  String get achFormatPro => 'Pro del Formato';

  @override
  String get achFormatProDesc => '100 niveles formato';

  @override
  String get achTimeLord => 'Señor del Tiempo';

  @override
  String get achTimeLordDesc => '100 niveles tiempo';

  @override
  String get achAlphabetizer => 'Alfabetizador';

  @override
  String get achAlphabetizerDesc => '100 niveles nombres';

  @override
  String get achMixMaster => 'Maestro Mixto';

  @override
  String get achMixMasterDesc => '100 niveles mixtos';

  @override
  String get achKnowledgeKing => 'Rey del Conocimiento';

  @override
  String get achKnowledgeKingDesc => '100 niveles conocimiento';

  @override
  String get achBasicPerfectionist => 'Perfeccionista Básico';

  @override
  String get achBasicPerfectionistDesc => '100% niveles básicos';

  @override
  String get achFormatPerfectionist => 'Perfeccionista Formato';

  @override
  String get achFormatPerfectionistDesc => '100% niveles formato';

  @override
  String get achTimePerfectionist => 'Perfeccionista Tiempo';

  @override
  String get achTimePerfectionistDesc => '100% niveles tiempo';

  @override
  String get achNamesPerfectionist => 'Perfeccionista Nombres';

  @override
  String get achNamesPerfectionistDesc => '100% niveles nombres';

  @override
  String get achMixedPerfectionist => 'Perfeccionista Mixto';

  @override
  String get achMixedPerfectionistDesc => '100% niveles mixtos';

  @override
  String get achKnowledgePerfectionist => 'Perf. Conocimiento';

  @override
  String get achKnowledgePerfectionistDesc => '100% conocimiento';

  @override
  String get achMemoryNovice => 'Novato Memoria';

  @override
  String get achMemoryNoviceDesc => '10 niveles Memoria';

  @override
  String get achMemoryExpert => 'Experto Memoria';

  @override
  String get achMemoryExpertDesc => '50 niveles Memoria';

  @override
  String get achMemoryMaster => 'Maestro Memoria';

  @override
  String get achMemoryMasterDesc => '100 niveles Memoria';

  @override
  String get achPerfectRecall => 'Recuerdo Perfecto';

  @override
  String get achPerfectRecallDesc => '5 Memoria perfectos';

  @override
  String get achMemoryPro => 'Pro Memoria';

  @override
  String get achMemoryProDesc => '10 Memoria perfectos';

  @override
  String get achMemoryGenius => 'Genio Memoria';

  @override
  String get achMemoryGeniusDesc => '25 Memoria perfectos';

  @override
  String get achEideticMemory => 'Memoria Eidética';

  @override
  String get achEideticMemoryDesc => '50 Memoria perfectos';

  @override
  String get achPhotographicMemory => 'Memoria Fotográfica';

  @override
  String get achPhotographicMemoryDesc => '100 Memoria perfectos';

  @override
  String get achMemoryBasicMaster => 'Maestro Básico Memoria';

  @override
  String get achMemoryBasicMasterDesc => 'Todo básico en Memoria';

  @override
  String get achMemoryFormatMaster => 'Maestro Formato Memoria';

  @override
  String get achMemoryFormatMasterDesc => 'Todo formato en Memoria';

  @override
  String get achMemoryTimeMaster => 'Maestro Tiempo Memoria';

  @override
  String get achMemoryTimeMasterDesc => 'Todo tiempo en Memoria';

  @override
  String get achMemoryNamesMaster => 'Maestro Nombres Memoria';

  @override
  String get achMemoryNamesMasterDesc => 'Todo nombres en Memoria';

  @override
  String get achMemoryMixedMaster => 'Maestro Mixto Memoria';

  @override
  String get achMemoryMixedMasterDesc => 'Todo mixto en Memoria';

  @override
  String get achDailyStarter => 'Iniciador Diario';

  @override
  String get achDailyStarterDesc => 'Primer desafío diario';

  @override
  String get achWeeklyChallenger => 'Retador Semanal';

  @override
  String get achWeeklyChallengerDesc => '7 desafíos diarios';

  @override
  String get achMonthlyChallenger => 'Retador Mensual';

  @override
  String get achMonthlyChallengerDesc => '30 desafíos diarios';

  @override
  String get achDailyLegend => 'Leyenda Diaria';

  @override
  String get achDailyLegendDesc => '100 desafíos diarios';

  @override
  String get achPerfectDay => 'Día Perfecto';

  @override
  String get achPerfectDayDesc => '5 diarios perfectos';

  @override
  String get achPerfectWeek => 'Semana Perfecta';

  @override
  String get achPerfectWeekDesc => '10 diarios perfectos';

  @override
  String get achPerfectStreak => 'Racha Perfecta';

  @override
  String get achPerfectStreakDesc => '25 diarios perfectos';

  @override
  String get achFlawlessPlayer => 'Jugador Impecable';

  @override
  String get achFlawlessPlayerDesc => '50 diarios perfectos';

  @override
  String get achDailyPerfectionist => 'Perfeccionista Diario';

  @override
  String get achDailyPerfectionistDesc => '100 diarios perfectos';

  @override
  String get achPartyHost => 'Anfitrión';

  @override
  String get achPartyHostDesc => '10 juegos multijugador';

  @override
  String get achSocialGamer => 'Jugador Social';

  @override
  String get achSocialGamerDesc => '25 juegos multijugador';

  @override
  String get achMultiplayerLegend => 'Leyenda Multijugador';

  @override
  String get achMultiplayerLegendDesc => '50 juegos multijugador';

  @override
  String get achPerfectRun => 'Carrera Perfecta';

  @override
  String get achPerfectRunDesc => '10 niveles sin errores';

  @override
  String get achDedicatedPlayer => 'Jugador Dedicado';

  @override
  String get achDedicatedPlayerDesc => '1 hora de juego total';

  @override
  String get achMarathonRunner => 'Maratonista';

  @override
  String get achMarathonRunnerDesc => '5 horas de juego total';

  @override
  String get achTotalMaster => 'Maestro Total';

  @override
  String get achTotalMasterDesc => '1100 niveles totales';

  @override
  String get achCompletionist => 'Completista';

  @override
  String get achCompletionistDesc => 'Desbloquea todos los logros';

  @override
  String get achNightOwl => 'Ave Nocturna';

  @override
  String get achNightOwlDesc => 'Juega 0-5 AM';

  @override
  String get achEarlyBird => 'Madrugador';

  @override
  String get achEarlyBirdDesc => 'Juega 5-7 AM';

  @override
  String get achNewYearSorter => 'Ordenador de Año Nuevo';

  @override
  String get achNewYearSorterDesc => 'Juega el 1 de enero';

  @override
  String get achNeverGiveUp => 'Nunca Rendirse';

  @override
  String get achNeverGiveUpDesc => 'Reintentar 50 veces';

  @override
  String get achInstantWin => 'Victoria Instantánea';

  @override
  String get achInstantWinDesc => 'Nivel en menos de 2s';

  @override
  String get achDescendingFan => 'Fan Descendente';

  @override
  String get achDescendingFanDesc => '20 descendentes seguidos';

  @override
  String get achSwapMaster => 'Maestro Intercambio';

  @override
  String get achSwapMasterDesc => '10 niveles solo swap';

  @override
  String get achShiftMaster => 'Maestro Desplazamiento';

  @override
  String get achShiftMasterDesc => '10 niveles solo shift';

  @override
  String get watchAd => 'Ver anuncio por oportunidad extra';

  @override
  String get goPro => 'Hazte Pro';

  @override
  String get noAds => 'Sin anuncios';

  @override
  String get noAdsDesc => 'Elimina todos los banners y anuncios intersticiales';

  @override
  String get unlimitedAttempts => 'Intentos ilimitados';

  @override
  String get unlimitedAttemptsDesc => 'Nunca te quedas sin oportunidades';

  @override
  String get proBadge => 'Insignia Pro';

  @override
  String get proBadgeDesc => 'Muestra tu estado premium';

  @override
  String get supportDev => 'Apoya al desarrollador';

  @override
  String get supportDevDesc => 'Ayúdanos a crear más contenido';

  @override
  String get whatYouGet => 'Lo que obtienes';

  @override
  String get processing => 'Procesando...';

  @override
  String get purchaseSuccess => '¡Bienvenido a Pro!';

  @override
  String get youAreNowPro =>
      '¡Ahora tienes acceso ilimitado a todas las funciones!';

  @override
  String get ok => 'OK';

  @override
  String get restorePurchases => 'Restaurar compras';

  @override
  String get noPurchasesToRestore => 'No se encontraron compras anteriores';

  @override
  String get alreadyPro => '¡Ya eres Pro!';
}
