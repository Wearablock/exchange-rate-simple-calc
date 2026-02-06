import 'package:flutter/material.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/services/preferences_service.dart';
import '../../../core/services/exchange_rate_service.dart';
import '../../../data/models/exchange_rate.dart';
import '../../../l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PreferencesService _prefsService = PreferencesService();
  final ExchangeRateService _exchangeService = ExchangeRateService();

  String _baseCurrency = 'USD';
  List<String> _watchList = [];
  ExchangeRateResponse? _rates;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final baseCurrency = _prefsService.baseCurrency;
    // 기준 통화를 관심 목록에서 제외
    final watchList = _prefsService.watchList
        .where((code) => code != baseCurrency)
        .toList();

    setState(() {
      _baseCurrency = baseCurrency;
      _watchList = watchList;
      _isLoading = true;
      _error = null;
    });

    // API에서 환율 데이터 가져오기
    final rates = await _exchangeService.getRates(_baseCurrency);

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (rates != null) {
          _rates = rates;
        } else {
          _error = 'Failed to load exchange rates';
        }
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    // 강제 새로고침
    final rates = await _exchangeService.refreshRates(_baseCurrency);

    if (mounted) {
      setState(() {
        _isLoading = false;
        if (rates != null) {
          _rates = rates;
        }
      });
    }
  }

  double _getRate(String targetCode) {
    return _rates?.getRateValue(targetCode) ?? 0;
  }

  String _getLastUpdatedText(AppLocalizations l10n) {
    final lastUpdate = _exchangeService.lastUpdateTime;
    if (lastUpdate == null || _rates == null) {
      return '${l10n.lastUpdated}: -';
    }

    final now = DateTime.now();
    final diff = now.difference(lastUpdate);

    if (diff.inMinutes < 1) {
      return '${l10n.lastUpdated}: ${l10n.justNow}';
    } else if (diff.inMinutes < 60) {
      return '${l10n.lastUpdated}: ${l10n.minutesAgo(diff.inMinutes)}';
    } else {
      return '${l10n.lastUpdated}: ${l10n.hoursAgo(diff.inHours)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final baseCurrencyInfo = Currencies.getByCode(_baseCurrency);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _refresh,
            tooltip: l10n.refresh,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refresh,
              child: CustomScrollView(
                slivers: [
                  // 기준 통화 헤더
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            baseCurrencyInfo?.flag ?? '💱',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${l10n.baseCurrency}: $_baseCurrency',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _getLastUpdatedText(l10n),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // 에러 상태
                  if (_error != null && _rates == null)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_off,
                              size: 64,
                              color: theme.colorScheme.error,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              l10n.loadingFailed,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.networkError,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: _loadData,
                              icon: const Icon(Icons.refresh),
                              label: Text(l10n.retry),
                            ),
                          ],
                        ),
                      ),
                    )
                  // 관심 통화 목록
                  else if (_watchList.isEmpty)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.currency_exchange,
                              size: 64,
                              color: theme.colorScheme.outline,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No currencies to display',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final currencyCode = _watchList[index];
                            return _RateCard(
                              baseCurrency: _baseCurrency,
                              targetCurrency: currencyCode,
                              rate: _getRate(currencyCode),
                              onSave: () => _showSaveDialog(currencyCode),
                            );
                          },
                          childCount: _watchList.length,
                        ),
                      ),
                    ),

                  // 하단 여백
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                ],
              ),
            ),
    );
  }

  void _showSaveDialog(String currencyCode) {
    // TODO: 환율 저장 다이얼로그 구현
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Save $_baseCurrency → $currencyCode'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }
}

class _RateCard extends StatelessWidget {
  final String baseCurrency;
  final String targetCurrency;
  final double rate;
  final VoidCallback onSave;

  const _RateCard({
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rate,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final isKorean = locale.languageCode == 'ko';

    final currencyInfo = Currencies.getByCode(targetCurrency);
    final baseCurrencyInfo = Currencies.getByCode(baseCurrency);
    final currencyName = isKorean
        ? currencyInfo?.nameKo ?? targetCurrency
        : currencyInfo?.name ?? targetCurrency;

    // 기준 통화의 baseUnit 적용
    final baseUnit = baseCurrencyInfo?.baseUnit ?? 1;
    final adjustedRate = rate * baseUnit;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 국기
            Text(
              currencyInfo?.flag ?? '💱',
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(width: 12),

            // 통화 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    targetCurrency,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currencyName,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),

            // 환율
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatRate(adjustedRate, targetCurrency),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _formatBaseUnit(baseUnit, baseCurrency),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 8),

            // 저장 버튼
            IconButton(
              icon: const Icon(Icons.bookmark_add_outlined),
              onPressed: onSave,
              tooltip: 'Save',
            ),
          ],
        ),
      ),
    );
  }

  String _formatBaseUnit(int baseUnit, String currencyCode) {
    if (baseUnit == 1) {
      return '1 $currencyCode';
    }
    return '$baseUnit $currencyCode';
  }

  String _formatRate(double rate, String targetCurrency) {
    final decimalPlaces = Currencies.getDecimalPlaces(targetCurrency);

    if (decimalPlaces == 0) {
      // 소수점 없는 통화 (KRW, JPY 등)
      return _formatWithComma(rate.round());
    } else if (rate >= 100) {
      return _formatWithComma(rate, decimals: 2);
    } else if (rate >= 1) {
      return rate.toStringAsFixed(4);
    } else {
      return rate.toStringAsFixed(6);
    }
  }

  String _formatWithComma(num value, {int decimals = 0}) {
    if (decimals == 0) {
      return value.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
    }
    final parts = value.toStringAsFixed(decimals).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return '$intPart.${parts[1]}';
  }
}
