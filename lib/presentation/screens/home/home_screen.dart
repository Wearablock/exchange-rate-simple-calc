import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/services/preferences_service.dart';
import '../../../core/services/exchange_rate_service.dart';
import '../../../data/models/exchange_rate.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/currency_select_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PreferencesService _prefsService = PreferencesService();
  final ExchangeRateService _exchangeService = ExchangeRateService();

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rightAmountController = TextEditingController();
  final FocusNode _leftFocusNode = FocusNode();
  final FocusNode _rightFocusNode = FocusNode();
  bool _isEditingLeft = false;
  bool _isEditingRight = false;

  String _baseCurrency = 'USD';
  List<String> _watchList = [];
  ExchangeRateResponse? _rates;
  bool _isLoading = true;
  String? _error;
  double _inputAmount = 1;

  @override
  void initState() {
    super.initState();
    _leftFocusNode.addListener(() => setState(() {}));
    _rightFocusNode.addListener(() => setState(() {}));
    _loadData();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _rightAmountController.dispose();
    _leftFocusNode.dispose();
    _rightFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final baseCurrency = _prefsService.baseCurrency;
    // 기준 통화를 관심 목록에서 제외
    final watchList = _prefsService.watchList
        .where((code) => code != baseCurrency)
        .toList();

    final baseUnit = Currencies.getByCode(baseCurrency)?.baseUnit ?? 1;

    setState(() {
      _baseCurrency = baseCurrency;
      _watchList = watchList;
      _inputAmount = baseUnit.toDouble();
      _isLoading = true;
      _error = null;
    });

    _amountController.text = _formatNumber(baseUnit.toDouble());

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
      _updateRightAmount();
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  // 환율 변환 카드
                  SliverToBoxAdapter(
                    child: _buildConverterHeader(theme, l10n),
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
                      sliver: SliverReorderableList(
                        itemBuilder: (context, index) {
                          final currencyCode = _watchList[index];
                          return _RateCard(
                            key: ValueKey(currencyCode),
                            index: index,
                            baseCurrency: _baseCurrency,
                            targetCurrency: currencyCode,
                            rate: _getRate(currencyCode),
                            inputAmount: _inputAmount,
                            onSave: () => _showSaveDialog(currencyCode),
                          );
                        },
                        itemCount: _watchList.length,
                        onReorder: _onReorder,
                      ),
                    ),

                  // 하단 여백
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  void _onLeftAmountChanged(String value) {
    if (_isEditingRight) return;
    _isEditingLeft = true;
    final cleaned = value.replaceAll(',', '');
    final parsed = double.tryParse(cleaned);
    setState(() {
      _inputAmount = parsed ?? 0;
    });
    _updateRightAmount();
    _isEditingLeft = false;
  }

  void _onRightAmountChanged(String value) {
    if (_isEditingLeft) return;
    _isEditingRight = true;
    final cleaned = value.replaceAll(',', '');
    final parsed = double.tryParse(cleaned);
    final rightAmount = parsed ?? 0;

    final topTarget = _watchList.isNotEmpty ? _watchList.first : null;
    final topRate = topTarget != null ? _getRate(topTarget) : 0.0;

    setState(() {
      _inputAmount = topRate > 0 ? rightAmount / topRate : 0;
    });
    _amountController.text = _formatNumber(_inputAmount);
    _isEditingRight = false;
  }

  Future<void> _changeBaseCurrency() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => CurrencySelectDialog(
        currentCurrency: _baseCurrency,
      ),
    );

    if (result != null && result != _baseCurrency) {
      await _prefsService.setBaseCurrency(result);
      _loadData();
    }
  }

  void _updateRightAmount() {
    final topTarget = _watchList.isNotEmpty ? _watchList.first : null;
    if (topTarget == null) return;
    final topRate = _getRate(topTarget);
    final converted = _inputAmount * topRate;
    _rightAmountController.text = _formatNumber(converted);
  }

  String _formatNumber(double value) {
    if (value == value.roundToDouble()) {
      return value.round().toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
    }
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return '$intPart.${parts[1]}';
  }

  Widget _buildConverterHeader(ThemeData theme, AppLocalizations l10n) {
    final baseCurrencyInfo = Currencies.getByCode(_baseCurrency);
    final locale = Localizations.localeOf(context);
    final isKorean = locale.languageCode == 'ko';

    // 오른쪽 카드: 관심 목록 첫 번째 통화
    final topTarget = _watchList.isNotEmpty ? _watchList.first : null;
    final topTargetInfo = topTarget != null ? Currencies.getByCode(topTarget) : null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // 상단: 기준 통화 (입력)
              Row(
                children: [
                  InkWell(
                    onTap: _changeBaseCurrency,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            baseCurrencyInfo?.flag ?? '💱',
                            style: const TextStyle(fontSize: 28),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _baseCurrency,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                isKorean
                                    ? baseCurrencyInfo?.nameKo ?? _baseCurrency
                                    : baseCurrencyInfo?.name ?? _baseCurrency,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.unfold_more,
                            size: 18,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      focusNode: _leftFocusNode,
                      autofocus: true,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                      ],
                      onChanged: _onLeftAmountChanged,
                      textAlign: TextAlign.end,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _leftFocusNode.hasFocus ? null : theme.colorScheme.primary,
                      ),
                      decoration: InputDecoration(
                        prefixText: '${baseCurrencyInfo?.symbol ?? ''} ',
                        prefixStyle: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        filled: true,
                        fillColor: _leftFocusNode.hasFocus
                            ? theme.inputDecorationTheme.fillColor
                            : theme.colorScheme.primary.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                ],
              ),

              // 구분선 + 쌍방향 화살표
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(
                        Icons.swap_vert,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    Expanded(child: Divider(color: theme.colorScheme.outlineVariant)),
                  ],
                ),
              ),

              // 하단: 첫 번째 관심 통화 (결과)
              if (topTarget != null)
                Row(
                  children: [
                    Text(
                      topTargetInfo?.flag ?? '💱',
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topTarget,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          isKorean
                              ? topTargetInfo?.nameKo ?? topTarget
                              : topTargetInfo?.name ?? topTarget,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _rightAmountController,
                        focusNode: _rightFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                        ],
                        onChanged: _onRightAmountChanged,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _rightFocusNode.hasFocus ? null : theme.colorScheme.primary,
                        ),
                        decoration: InputDecoration(
                          prefixText: '${topTargetInfo?.symbol ?? ''} ',
                          prefixStyle: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          filled: true,
                          fillColor: _rightFocusNode.hasFocus
                              ? theme.inputDecorationTheme.fillColor
                              : theme.colorScheme.primary.withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Center(
                  child: Text('-', style: theme.textTheme.titleLarge),
                ),

              // 마지막 업데이트
              const SizedBox(height: 8),
              Text(
                _getLastUpdatedText(l10n),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final item = _watchList.removeAt(oldIndex);
      _watchList.insert(newIndex, item);
    });
    _prefsService.setWatchList(_watchList);
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
  final int index;
  final String baseCurrency;
  final String targetCurrency;
  final double rate;
  final double inputAmount;
  final VoidCallback onSave;

  const _RateCard({
    super.key,
    required this.index,
    required this.baseCurrency,
    required this.targetCurrency,
    required this.rate,
    required this.inputAmount,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final isKorean = locale.languageCode == 'ko';

    final currencyInfo = Currencies.getByCode(targetCurrency);
    final currencyName = isKorean
        ? currencyInfo?.nameKo ?? targetCurrency
        : currencyInfo?.name ?? targetCurrency;

    // 입력 금액 기반으로 환산
    final adjustedRate = rate * inputAmount;

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
                  _formatBaseUnit(inputAmount, baseCurrency),
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

            // 드래그 핸들
            ReorderableDragStartListener(
              index: index,
              child: const Icon(
                Icons.drag_handle,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatBaseUnit(double amount, String currencyCode) {
    final display = amount == amount.roundToDouble()
        ? amount.round().toString().replaceAllMapped(
              RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
              (match) => '${match[1]},',
            )
        : amount.toStringAsFixed(2);
    return '$display $currencyCode';
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
