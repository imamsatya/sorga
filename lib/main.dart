import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/services/achievement_service.dart';
import 'data/datasources/local_database.dart';
import 'presentation/router/app_router.dart';
import 'presentation/providers/locale_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  
  // Initialize database
  await LocalDatabase.instance.init();
  
  // Initialize achievement service
  await AchievementService.instance.init();
  
  runApp(const ProviderScope(child: SorgaApp()));
}

/// Custom scroll behavior to enable mouse/trackpad drag scrolling on web
class WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class SorgaApp extends ConsumerWidget {
  const SorgaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch locale provider for in-app language switching
    final selectedLocale = ref.watch(localeProvider);
    
    return MaterialApp.router(
      title: 'Sorga',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
      // Enable mouse/trackpad drag scrolling on web
      scrollBehavior: WebScrollBehavior(),
      // Use selected locale if set, otherwise use system default
      locale: selectedLocale,
      // Localization Configuration
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: supportedLocales,
    );
  }
}
