import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'l10n/app_localizations.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/services/ad_service.dart';
import 'core/services/iap_service.dart';
import 'core/services/preferences_service.dart';
import 'presentation/screens/main/main_shell.dart';
import 'presentation/screens/onboarding/onboarding_screen.dart';

void main() async {
  // 스플래시 유지
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 서비스 초기화
  await PreferencesService().initialize();
  await AdService().initialize();
  await IAPService().initialize();

  // 스플래시 종료
  FlutterNativeSplash.remove();

  runApp(
    const ProviderScope(
      child: EasyExchangeApp(),
    ),
  );
}

class EasyExchangeApp extends StatefulWidget {
  const EasyExchangeApp({super.key});

  static void setLocale(BuildContext context, String? code) {
    final state = context.findAncestorStateOfType<_EasyExchangeAppState>();
    state?._setLocale(code);
  }

  static void setThemeMode(BuildContext context, String mode) {
    final state = context.findAncestorStateOfType<_EasyExchangeAppState>();
    state?._setThemeMode(mode);
  }

  @override
  State<EasyExchangeApp> createState() => _EasyExchangeAppState();
}

class _EasyExchangeAppState extends State<EasyExchangeApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;
  bool _isOnboardingComplete = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    final prefs = PreferencesService();
    setState(() {
      _themeMode = _getThemeModeFromString(prefs.themeMode);
      _locale = _parseLocale(prefs.languageCode);
      _isOnboardingComplete = prefs.isOnboardingComplete;
    });
  }

  void _setLocale(String? code) {
    setState(() {
      _locale = _parseLocale(code);
    });
  }

  void _setThemeMode(String mode) {
    setState(() {
      _themeMode = _getThemeModeFromString(mode);
    });
  }

  static Locale? _parseLocale(String? code) {
    if (code == null) return null;
    if (code.contains('_')) {
      final parts = code.split('_');
      return Locale.fromSubtags(
        languageCode: parts[0],
        scriptCode: parts[1],
      );
    }
    return Locale(code);
  }

  ThemeMode _getThemeModeFromString(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void _onOnboardingComplete() {
    setState(() {
      _isOnboardingComplete = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // 테마
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,

      // 다국어
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppConfig.supportedLocales,

      // 온보딩 여부에 따라 화면 분기
      home: _isOnboardingComplete
          ? const MainShell()
          : OnboardingScreen(onComplete: _onOnboardingComplete),
    );
  }
}

