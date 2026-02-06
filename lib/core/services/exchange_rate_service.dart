import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/exchange_rate.dart';
import '../config/app_config.dart';

class ExchangeRateService {
  // ============================================================
  // 싱글톤 패턴
  // ============================================================

  static final ExchangeRateService _instance = ExchangeRateService._internal();
  factory ExchangeRateService() => _instance;
  ExchangeRateService._internal();

  // ============================================================
  // Frankfurter API 설정
  // ============================================================

  static const String _baseUrl = 'https://api.frankfurter.app';

  // 캐시 키
  static const String _cacheKeyPrefix = 'exchange_rate_cache_';
  static const String _cacheTimestampKey = 'exchange_rate_timestamp_';

  // 메모리 캐시
  ExchangeRateResponse? _memoryCache;
  String? _memoryCacheBase;
  DateTime? _memoryCacheTime;

  // ============================================================
  // 환율 조회
  // ============================================================

  /// 환율 조회 (캐싱 적용)
  Future<ExchangeRateResponse?> getRates(String baseCurrency) async {
    // 1. 메모리 캐시 확인
    if (_isMemoryCacheValid(baseCurrency)) {
      debugPrint('[ExchangeRateService] 메모리 캐시 반환');
      return _memoryCache;
    }

    // 2. 로컬 캐시 확인
    final localCache = await _getLocalCache(baseCurrency);
    if (localCache != null) {
      debugPrint('[ExchangeRateService] 로컬 캐시 반환');
      _updateMemoryCache(baseCurrency, localCache);
      return localCache;
    }

    // 3. API 호출
    try {
      final response = await _fetchFromApi(baseCurrency);
      if (response != null) {
        await _saveToLocalCache(baseCurrency, response);
        _updateMemoryCache(baseCurrency, response);
        debugPrint('[ExchangeRateService] API 응답 반환');
        return response;
      }
    } catch (e) {
      debugPrint('[ExchangeRateService] API 호출 실패: $e');
    }

    // 4. 만료된 로컬 캐시라도 반환 (오프라인 대비)
    final expiredCache = await _getLocalCache(baseCurrency, ignoreExpiry: true);
    if (expiredCache != null) {
      debugPrint('[ExchangeRateService] 만료된 캐시 반환 (오프라인)');
      return expiredCache;
    }

    return null;
  }

  /// 강제 새로고침
  Future<ExchangeRateResponse?> refreshRates(String baseCurrency) async {
    try {
      final response = await _fetchFromApi(baseCurrency);
      if (response != null) {
        await _saveToLocalCache(baseCurrency, response);
        _updateMemoryCache(baseCurrency, response);
        return response;
      }
    } catch (e) {
      debugPrint('[ExchangeRateService] 새로고침 실패: $e');
    }
    return null;
  }

  // ============================================================
  // Frankfurter API 호출
  // ============================================================

  Future<ExchangeRateResponse?> _fetchFromApi(String baseCurrency) async {
    // Frankfurter API URL
    // https://api.frankfurter.app/latest?from=USD
    final url = '$_baseUrl/latest?from=$baseCurrency';

    try {
      debugPrint('[ExchangeRateService] API 호출: $url');

      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return ExchangeRateResponse.fromFrankfurterJson(json);
      } else {
        debugPrint('[ExchangeRateService] HTTP 오류: ${response.statusCode}');
        debugPrint('[ExchangeRateService] 응답: ${response.body}');
      }
    } catch (e) {
      debugPrint('[ExchangeRateService] 네트워크 오류: $e');
      rethrow;
    }

    return null;
  }

  // ============================================================
  // 메모리 캐시
  // ============================================================

  bool _isMemoryCacheValid(String baseCurrency) {
    if (_memoryCache == null ||
        _memoryCacheBase != baseCurrency ||
        _memoryCacheTime == null) {
      return false;
    }

    final elapsed = DateTime.now().difference(_memoryCacheTime!);
    return elapsed < AppConfig.memoryCacheExpiry;
  }

  void _updateMemoryCache(String baseCurrency, ExchangeRateResponse response) {
    _memoryCache = response;
    _memoryCacheBase = baseCurrency;
    _memoryCacheTime = DateTime.now();
  }

  // ============================================================
  // 로컬 캐시 (SharedPreferences)
  // ============================================================

  Future<ExchangeRateResponse?> _getLocalCache(
    String baseCurrency, {
    bool ignoreExpiry = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '$_cacheKeyPrefix$baseCurrency';
    final timestampKey = '$_cacheTimestampKey$baseCurrency';

    final cachedData = prefs.getString(cacheKey);
    final cachedTimestamp = prefs.getInt(timestampKey);

    if (cachedData == null || cachedTimestamp == null) {
      return null;
    }

    // 만료 체크
    if (!ignoreExpiry) {
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(cachedTimestamp);
      final elapsed = DateTime.now().difference(cacheTime);
      if (elapsed > AppConfig.localCacheExpiry) {
        return null;
      }
    }

    try {
      final json = jsonDecode(cachedData) as Map<String, dynamic>;
      return ExchangeRateResponse.fromJson(json);
    } catch (e) {
      debugPrint('[ExchangeRateService] 캐시 파싱 오류: $e');
      return null;
    }
  }

  Future<void> _saveToLocalCache(
    String baseCurrency,
    ExchangeRateResponse response,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = '$_cacheKeyPrefix$baseCurrency';
    final timestampKey = '$_cacheTimestampKey$baseCurrency';

    await prefs.setString(cacheKey, jsonEncode(response.toJson()));
    await prefs.setInt(timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  // ============================================================
  // 유틸리티
  // ============================================================

  /// 마지막 업데이트 시간
  DateTime? get lastUpdateTime => _memoryCacheTime;

  /// 캐시된 환율 데이터
  ExchangeRateResponse? get cachedRates => _memoryCache;
}
