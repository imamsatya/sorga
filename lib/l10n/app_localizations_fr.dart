// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Sorga';

  @override
  String get home => 'Accueil';

  @override
  String get play => 'Jouer';

  @override
  String get achievements => 'Succès';

  @override
  String get statistics => 'Statistiques';

  @override
  String get chooseCategory => 'Choisir une Catégorie';

  @override
  String levelCompleted(Object id) {
    return 'Niveau $id Terminé!';
  }

  @override
  String get sortItems => 'Trier les éléments';

  @override
  String get sortNames => 'Trier les noms';

  @override
  String get lowToHigh => 'Petit → Grand';

  @override
  String get highToLow => 'Grand → Petit';

  @override
  String get aToZ => 'A → Z';

  @override
  String get zToA => 'Z → A';

  @override
  String get nextLevel => 'Niveau Suivant';

  @override
  String get retry => 'Réessayer';

  @override
  String get dailyChallenge => 'Défi Quotidien';

  @override
  String get streak => 'Série';

  @override
  String get perfect => 'PARFAIT!';

  @override
  String get tryAgain => 'RÉESSAYEZ';

  @override
  String get completed => 'terminé';

  @override
  String get basicNumbers => 'Nombres de Base';

  @override
  String get formattedNumbers => 'Formatés';

  @override
  String get timeFormats => 'Formats de Temps';

  @override
  String get nameSorting => 'Tri de Noms';

  @override
  String get mixedFormats => 'Formats Mixtes';

  @override
  String get knowledge => 'Connaissance';

  @override
  String get levels => 'niveaux';

  @override
  String get share => 'Partager';

  @override
  String get close => 'Fermer';

  @override
  String get yourTime => 'VOTRE TEMPS';

  @override
  String get continueGame => 'CONTINUER';

  @override
  String get retryLevel => 'RÉESSAYER LE NIVEAU';

  @override
  String get yourSortingParadise => 'Votre Paradis du Tri';

  @override
  String get done => 'Terminé';

  @override
  String get progress => 'Progrès';

  @override
  String get time => 'Temps';

  @override
  String get day => 'jour';

  @override
  String get days => 'jours';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get systemDefault => 'Par Défaut du Système';

  @override
  String get soundEffects => 'Effets Sonores';

  @override
  String get vibration => 'Vibration';

  @override
  String get check => 'Vérifier';

  @override
  String get level => 'Niveau';

  @override
  String get items => 'éléments';

  @override
  String get sortAscending => 'Tri ASC';

  @override
  String get sortDescending => 'Tri DESC';

  @override
  String get best => 'Meilleur';

  @override
  String sortXItems(Object count, Object type, Object direction) {
    return 'Trier $count $type $direction';
  }

  @override
  String get playAgain => 'Rejouer';

  @override
  String get startChallenge => 'DÉMARRER LE DÉFI';

  @override
  String get completedToday => 'Terminé Aujourd\'hui!';

  @override
  String get comeBackTomorrow => 'Revenez demain pour un nouveau défi';

  @override
  String get shareResult => 'Partager le Résultat';

  @override
  String get shareAchievement => 'Partager le Succès';

  @override
  String get canYouBeatMyTime => 'Pouvez-vous battre mon temps?';

  @override
  String get dailyStreak => 'Série Quotidienne';

  @override
  String get dailyStreakActive => 'Série Quotidienne Active!';

  @override
  String get categoryProgress => 'Progression par Catégorie';

  @override
  String get completedLevels => 'Niveaux Terminés';

  @override
  String get currentStreak => 'Série Actuelle';

  @override
  String get longestStreak => 'Meilleure Série';

  @override
  String get totalPlayTime => 'Temps de Jeu Total';

  @override
  String get totalAttempts => 'Tentatives Totales';

  @override
  String get achievementsTitle => 'Succès';

  @override
  String get statisticsTitle => 'Statistiques';

  @override
  String get selectLevel => 'Sélectionner le Niveau';

  @override
  String get about => 'À propos';

  @override
  String get appDescription => 'Sorga - Un Jeu de Tri';

  @override
  String get version => 'Version';

  @override
  String get levelsDescription =>
      '1100 niveaux dans 11 catégories. Entraînez votre cerveau avec des chiffres, du temps, des noms et plus!';

  @override
  String get dragAndDrop => 'Glisser-Déposer';

  @override
  String get dragItemsDescription =>
      'Faites glisser les éléments pour les réorganiser dans le bon ordre';

  @override
  String get skip => 'Passer';

  @override
  String get next => 'SUIVANT';

  @override
  String get shift => 'Décaler';

  @override
  String get swap => 'Échanger';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get daily => 'Quotidien';

  @override
  String get orderNotRight => 'L\'ordre n\'est pas tout à fait correct.';

  @override
  String chancesLeft(Object count) {
    return 'Il vous reste $count chance(s)!';
  }

  @override
  String get sort => 'Trier';

  @override
  String get asc => 'ASC';

  @override
  String get desc => 'DESC';

  @override
  String get thursday => 'Jeudi';

  @override
  String get friday => 'Vendredi';

  @override
  String get saturday => 'Samedi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get monday => 'Lundi';

  @override
  String get tuesday => 'Mardi';

  @override
  String get wednesday => 'Mercredi';

  @override
  String get getReady => 'Préparez-vous!';

  @override
  String get attempt => 'Tentative';

  @override
  String get noMoreChances => 'Plus de chances. Réessayez!';

  @override
  String xOfYCompleted(Object x, Object y) {
    return '$x / $y terminé';
  }

  @override
  String get sortTheItems => 'Triez les éléments';

  @override
  String get tapCheckWhenDone =>
      'Appuyez sur Vérifier quand vous avez terminé.';

  @override
  String get useDragMode => 'Utilisez le mode Décaler ou Échanger';

  @override
  String get shiftModeDescription =>
      'Le mode Décaler fait glisser les éléments. Le mode Échanger échange les positions.';

  @override
  String get youreReady => 'Vous êtes prêt!';

  @override
  String get startSorting =>
      'Commencez à trier et battez votre meilleur temps!';

  @override
  String get bestTime => 'Meilleur Temps';

  @override
  String get attempts => 'Tentatives';

  @override
  String get iCompletedLevel =>
      'Je viens de terminer ce niveau dans Sorga ! Pouvez-vous battre mon temps ?';

  @override
  String get dailyChallengeShare => '🎯 Sorga Défi Quotidien';

  @override
  String get shiftAndSwap => 'Décaler & Échanger';

  @override
  String get shiftAndSwapDescription =>
      'Utilisez le mode DÉCALER pour déplacer les éléments étape par étape, ou ÉCHANGER pour changer les positions';

  @override
  String get checkAnswer => 'Vérifier la Réponse';

  @override
  String get checkAnswerDescription =>
      'Quand vous êtes prêt, appuyez sur VÉRIFIER pour confirmer votre réponse. Bonne chance !';

  @override
  String get startPlaying => 'COMMENCER À JOUER';

  @override
  String get january => 'Janvier';

  @override
  String get february => 'Février';

  @override
  String get march => 'Mars';

  @override
  String get april => 'Avril';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Juin';

  @override
  String get july => 'Juillet';

  @override
  String get august => 'Août';

  @override
  String get september => 'Septembre';

  @override
  String get october => 'Octobre';

  @override
  String get november => 'Novembre';

  @override
  String get december => 'Décembre';

  @override
  String get numbers => 'nombres';

  @override
  String get times => 'heures';

  @override
  String get names => 'Noms';

  @override
  String get memorized => 'Mémorisé !';

  @override
  String get memoryMode => 'Mémoire';

  @override
  String get memorizeTime => 'Mémoriser';

  @override
  String get sortTime => 'Trier';

  @override
  String get totalTime => 'Temps Total';

  @override
  String completeLevelToUnlock(Object level, Object category) {
    return 'Terminer le niveau $level dans $category pour débloquer';
  }

  @override
  String sortDescription(Object count, Object type, Object direction) {
    return 'Trier $count $type $direction';
  }

  @override
  String get ascending => 'croissant';

  @override
  String get descending => 'décroissant';

  @override
  String get multiplayer => 'Multijoueur';

  @override
  String get multiplayerSetup => 'Configuration Multijoueur';

  @override
  String get selectCategory => 'Choisir une catégorie';

  @override
  String get itemCount => 'Nombre d\'éléments';

  @override
  String get playerCount => 'Nombre de joueurs';

  @override
  String playerName(Object number) {
    return 'Nom du joueur $number';
  }

  @override
  String get startGame => 'Commencer';

  @override
  String getReadyPlayer(Object name) {
    return '$name, prépare-toi!';
  }

  @override
  String get yourTurn => 'C\'est ton tour!';

  @override
  String get tapToStart => 'Appuyer pour commencer';

  @override
  String get giveUp => 'Abandonner';

  @override
  String get failed => 'Échoué';

  @override
  String get failedNextPlayer => 'Échoué! Suivant...';

  @override
  String continueLeft(Object count) {
    return 'Continuer ($count restants)';
  }

  @override
  String get draw => 'Égalité!';

  @override
  String get everyoneGaveUp => 'Tout le monde a abandonné!';

  @override
  String get everyoneFailed => 'Tout le monde a échoué!';

  @override
  String get noOneCompleted => 'Personne n\'a réussi!';

  @override
  String get leaderboard => 'Classement';

  @override
  String get localMultiplayer => 'Multijoueur local';

  @override
  String get players => 'Joueurs';

  @override
  String get addPlayer => 'Ajouter un joueur';

  @override
  String get removePlayer => 'Supprimer';

  @override
  String get category => 'Catégorie';

  @override
  String get ready => 'Prêt?';

  @override
  String get go => 'GO!';

  @override
  String get complete => 'terminé';

  @override
  String get unlocked => 'débloqué';

  @override
  String get locked => 'Verrouillé';

  @override
  String get secretAchievement => 'Succès secret';

  @override
  String get dailyChallenges => 'Défis Quotidiens';

  @override
  String get dailyCompleted => 'Terminés';

  @override
  String get perfectCompletions => 'Parfait';

  @override
  String get multiplayerGames => 'Multijoueur';

  @override
  String get memoryProgress => 'Progrès Mémoire';

  @override
  String get achFirstSteps => 'Premiers Pas';

  @override
  String get achFirstStepsDesc => 'Termine ton premier niveau';

  @override
  String get achGettingStarted => 'Débuter';

  @override
  String get achGettingStartedDesc => 'Termine 10 niveaux';

  @override
  String get achOnARoll => 'En Forme';

  @override
  String get achOnARollDesc => 'Termine 50 niveaux';

  @override
  String get achCenturyClub => 'Club des 100';

  @override
  String get achCenturyClubDesc => 'Termine 100 niveaux';

  @override
  String get achHalfwayThere => 'À Mi-Chemin';

  @override
  String get achHalfwayThereDesc => 'Termine 500 niveaux';

  @override
  String get achSortingMaster => 'Maître du Tri';

  @override
  String get achSortingMasterDesc => 'Termine les 600 niveaux';

  @override
  String get achConsistent => 'Constant';

  @override
  String get achConsistentDesc => 'Joue 3 jours de suite';

  @override
  String get achWeekWarrior => 'Guerrier Hebdo';

  @override
  String get achWeekWarriorDesc => 'Joue 7 jours de suite';

  @override
  String get achMonthlyMaster => 'Maître Mensuel';

  @override
  String get achMonthlyMasterDesc => 'Joue 30 jours de suite';

  @override
  String get achLegendaryStreak => 'Série Légendaire';

  @override
  String get achLegendaryStreakDesc => 'Joue 100 jours de suite';

  @override
  String get achSpeedDemon => 'Démon de Vitesse';

  @override
  String get achSpeedDemonDesc => 'Niveau en moins de 5s';

  @override
  String get achLightningFast => 'Éclair';

  @override
  String get achLightningFastDesc => 'Niveau en moins de 3s';

  @override
  String get achBasicExpert => 'Expert Basique';

  @override
  String get achBasicExpertDesc => '100 niveaux basiques';

  @override
  String get achFormatPro => 'Pro du Format';

  @override
  String get achFormatProDesc => '100 niveaux format';

  @override
  String get achTimeLord => 'Maître du Temps';

  @override
  String get achTimeLordDesc => '100 niveaux temps';

  @override
  String get achAlphabetizer => 'Alphabétiseur';

  @override
  String get achAlphabetizerDesc => '100 niveaux noms';

  @override
  String get achMixMaster => 'Maître du Mix';

  @override
  String get achMixMasterDesc => '100 niveaux mixtes';

  @override
  String get achKnowledgeKing => 'Roi du Savoir';

  @override
  String get achKnowledgeKingDesc => '100 niveaux connaissance';

  @override
  String get achBasicPerfectionist => 'Perfection. Basique';

  @override
  String get achBasicPerfectionistDesc => '100% niveaux basiques';

  @override
  String get achFormatPerfectionist => 'Perfection. Format';

  @override
  String get achFormatPerfectionistDesc => '100% niveaux format';

  @override
  String get achTimePerfectionist => 'Perfection. Temps';

  @override
  String get achTimePerfectionistDesc => '100% niveaux temps';

  @override
  String get achNamesPerfectionist => 'Perfection. Noms';

  @override
  String get achNamesPerfectionistDesc => '100% niveaux noms';

  @override
  String get achMixedPerfectionist => 'Perfection. Mixte';

  @override
  String get achMixedPerfectionistDesc => '100% niveaux mixtes';

  @override
  String get achKnowledgePerfectionist => 'Perfection. Savoir';

  @override
  String get achKnowledgePerfectionistDesc => '100% connaissance';

  @override
  String get achMemoryNovice => 'Novice Mémoire';

  @override
  String get achMemoryNoviceDesc => '10 niveaux Mémoire';

  @override
  String get achMemoryExpert => 'Expert Mémoire';

  @override
  String get achMemoryExpertDesc => '50 niveaux Mémoire';

  @override
  String get achMemoryMaster => 'Maître Mémoire';

  @override
  String get achMemoryMasterDesc => '100 niveaux Mémoire';

  @override
  String get achPerfectRecall => 'Rappel Parfait';

  @override
  String get achPerfectRecallDesc => '5 Mémoire parfaits';

  @override
  String get achMemoryPro => 'Pro Mémoire';

  @override
  String get achMemoryProDesc => '10 Mémoire parfaits';

  @override
  String get achMemoryGenius => 'Génie Mémoire';

  @override
  String get achMemoryGeniusDesc => '25 Mémoire parfaits';

  @override
  String get achEideticMemory => 'Mémoire Eidétique';

  @override
  String get achEideticMemoryDesc => '50 Mémoire parfaits';

  @override
  String get achPhotographicMemory => 'Mémoire Photographique';

  @override
  String get achPhotographicMemoryDesc => '100 Mémoire parfaits';

  @override
  String get achMemoryBasicMaster => 'Maître Basique Mémoire';

  @override
  String get achMemoryBasicMasterDesc => 'Tout basique en Mémoire';

  @override
  String get achMemoryFormatMaster => 'Maître Format Mémoire';

  @override
  String get achMemoryFormatMasterDesc => 'Tout format en Mémoire';

  @override
  String get achMemoryTimeMaster => 'Maître Temps Mémoire';

  @override
  String get achMemoryTimeMasterDesc => 'Tout temps en Mémoire';

  @override
  String get achMemoryNamesMaster => 'Maître Noms Mémoire';

  @override
  String get achMemoryNamesMasterDesc => 'Tout noms en Mémoire';

  @override
  String get achMemoryMixedMaster => 'Maître Mixte Mémoire';

  @override
  String get achMemoryMixedMasterDesc => 'Tout mixte en Mémoire';

  @override
  String get achDailyStarter => 'Début Quotidien';

  @override
  String get achDailyStarterDesc => 'Premier défi quotidien';

  @override
  String get achWeeklyChallenger => 'Challenger Hebdo';

  @override
  String get achWeeklyChallengerDesc => '7 défis quotidiens';

  @override
  String get achMonthlyChallenger => 'Challenger Mensuel';

  @override
  String get achMonthlyChallengerDesc => '30 défis quotidiens';

  @override
  String get achDailyLegend => 'Légende Quotidienne';

  @override
  String get achDailyLegendDesc => '100 défis quotidiens';

  @override
  String get achPerfectDay => 'Jour Parfait';

  @override
  String get achPerfectDayDesc => '5 quotidiens parfaits';

  @override
  String get achPerfectWeek => 'Semaine Parfaite';

  @override
  String get achPerfectWeekDesc => '10 quotidiens parfaits';

  @override
  String get achPerfectStreak => 'Série Parfaite';

  @override
  String get achPerfectStreakDesc => '25 quotidiens parfaits';

  @override
  String get achFlawlessPlayer => 'Joueur Impeccable';

  @override
  String get achFlawlessPlayerDesc => '50 quotidiens parfaits';

  @override
  String get achDailyPerfectionist => 'Perfection. Quotidien';

  @override
  String get achDailyPerfectionistDesc => '100 quotidiens parfaits';

  @override
  String get achPartyHost => 'Hôte de Fête';

  @override
  String get achPartyHostDesc => '10 parties multijoueur';

  @override
  String get achSocialGamer => 'Joueur Social';

  @override
  String get achSocialGamerDesc => '25 parties multijoueur';

  @override
  String get achMultiplayerLegend => 'Légende Multijoueur';

  @override
  String get achMultiplayerLegendDesc => '50 parties multijoueur';

  @override
  String get achPerfectRun => 'Course Parfaite';

  @override
  String get achPerfectRunDesc => '10 niveaux sans erreur';

  @override
  String get achDedicatedPlayer => 'Joueur Dévoué';

  @override
  String get achDedicatedPlayerDesc => '1 heure de jeu total';

  @override
  String get achMarathonRunner => 'Marathonien';

  @override
  String get achMarathonRunnerDesc => '5 heures de jeu total';

  @override
  String get achTotalMaster => 'Maître Total';

  @override
  String get achTotalMasterDesc => '1100 niveaux totaux';

  @override
  String get achCompletionist => 'Complétionniste';

  @override
  String get achCompletionistDesc => 'Débloque tous les succès';

  @override
  String get achNightOwl => 'Oiseau de Nuit';

  @override
  String get achNightOwlDesc => 'Joue 0h-5h';

  @override
  String get achEarlyBird => 'Lève-Tôt';

  @override
  String get achEarlyBirdDesc => 'Joue 5h-7h';

  @override
  String get achNewYearSorter => 'Trieur du Nouvel An';

  @override
  String get achNewYearSorterDesc => 'Joue le 1er janvier';

  @override
  String get achNeverGiveUp => 'Ne Jamais Abandonner';

  @override
  String get achNeverGiveUpDesc => 'Réessayer 50 fois';

  @override
  String get achInstantWin => 'Victoire Instantanée';

  @override
  String get achInstantWinDesc => 'Niveau en moins de 2s';

  @override
  String get achDescendingFan => 'Fan Descendant';

  @override
  String get achDescendingFanDesc => '20 descendants de suite';

  @override
  String get achSwapMaster => 'Maître Échange';

  @override
  String get achSwapMasterDesc => '10 niveaux swap seul';

  @override
  String get achShiftMaster => 'Maître Décalage';

  @override
  String get achShiftMasterDesc => '10 niveaux shift seul';
}
