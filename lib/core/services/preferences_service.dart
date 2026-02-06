import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;
  PreferencesService._internal();

  SharedPreferences? _prefs;

  // 키 상수
  static const String _keyBaseCurrency = 'base_currency';
  static const String _keyWatchList = 'watch_list';
  static const String _keyThemeMode = 'theme_mode';
  static const String _keyOnboardingComplete = 'onboarding_complete';
  static const String _keyLanguageCode = 'language_code';
  static const String _keyHistoryGroupOrder = 'history_group_order';

  // 기본값
  static const String _defaultBaseCurrency = 'USD';
  static const List<String> _defaultWatchList = ['KRW', 'JPY', 'EUR', 'GBP', 'CNY'];

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    debugPrint('[PreferencesService] 초기화 완료');
  }

  // ============================================================
  // 기준 통화
  // ============================================================
  String get baseCurrency {
    return _prefs?.getString(_keyBaseCurrency) ?? _defaultBaseCurrency;
  }

  Future<void> setBaseCurrency(String currency) async {
    await _prefs?.setString(_keyBaseCurrency, currency);
    debugPrint('[PreferencesService] 기준 통화 설정: $currency');
  }

  // ============================================================
  // 관심 통화 목록
  // ============================================================
  List<String> get watchList {
    return _prefs?.getStringList(_keyWatchList) ?? _defaultWatchList;
  }

  Future<void> setWatchList(List<String> currencies) async {
    await _prefs?.setStringList(_keyWatchList, currencies);
    debugPrint('[PreferencesService] 관심 통화 설정: $currencies');
  }

  Future<void> addToWatchList(String currency) async {
    final list = watchList;
    if (!list.contains(currency)) {
      list.add(currency);
      await setWatchList(list);
    }
  }

  Future<void> removeFromWatchList(String currency) async {
    final list = watchList;
    list.remove(currency);
    await setWatchList(list);
  }

  // ============================================================
  // 테마 모드
  // ============================================================
  String get themeMode {
    return _prefs?.getString(_keyThemeMode) ?? 'system';
  }

  Future<void> setThemeMode(String mode) async {
    await _prefs?.setString(_keyThemeMode, mode);
    debugPrint('[PreferencesService] 테마 모드 설정: $mode');
  }

  // ============================================================
  // 온보딩 완료 여부
  // ============================================================
  bool get isOnboardingComplete {
    return _prefs?.getBool(_keyOnboardingComplete) ?? false;
  }

  Future<void> setOnboardingComplete(bool value) async {
    await _prefs?.setBool(_keyOnboardingComplete, value);
    debugPrint('[PreferencesService] 온보딩 완료: $value');
  }

  // ============================================================
  // 언어 설정
  // ============================================================
  String? get languageCode {
    return _prefs?.getString(_keyLanguageCode);
  }

  Future<void> setLanguageCode(String? code) async {
    if (code == null) {
      await _prefs?.remove(_keyLanguageCode);
    } else {
      await _prefs?.setString(_keyLanguageCode, code);
    }
    debugPrint('[PreferencesService] 언어 설정: $code');
  }

  // ============================================================
  // 기록 그룹 순서
  // ============================================================
  List<String> get historyGroupOrder {
    return _prefs?.getStringList(_keyHistoryGroupOrder) ?? [];
  }

  Future<void> setHistoryGroupOrder(List<String> order) async {
    await _prefs?.setStringList(_keyHistoryGroupOrder, order);
  }

  // ============================================================
  // 전체 초기화
  // ============================================================
  Future<void> clear() async {
    await _prefs?.clear();
    debugPrint('[PreferencesService] 설정 초기화');
  }
}
