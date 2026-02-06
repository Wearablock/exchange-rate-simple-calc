import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/services/rate_history_service.dart';
import '../../../core/services/preferences_service.dart';
import '../../../core/services/ad_service.dart';
import '../../../core/services/iap_service.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/app_localizations.dart';
import '../../widgets/ad_badge.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final RateHistoryService _historyService = RateHistoryService();
  final PreferencesService _prefsService = PreferencesService();
  final AdService _adService = AdService();
  final IAPService _iapService = IAPService();
  List<SavedRate> _savedRates = [];
  List<String> _groupOrder = [];
  bool _isLoading = true;
  StreamSubscription<List<SavedRate>>? _subscription;

  @override
  void initState() {
    super.initState();
    _groupOrder = _prefsService.historyGroupOrder;
    _subscription = _historyService.watchAllRecords().listen((rates) {
      setState(() {
        _savedRates = rates;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  /// 통화쌍별로 그루핑 (저장된 순서 우선, 새 그룹은 알파벳순 추가)
  Map<String, List<SavedRate>> _groupByPair() {
    final map = <String, List<SavedRate>>{};

    for (final rate in _savedRates) {
      final key = '${rate.baseCode}→${rate.targetCode}';
      map.putIfAbsent(key, () => []).add(rate);
    }

    // 각 그룹 내 최신순 정렬
    for (final list in map.values) {
      list.sort((a, b) => b.savedAt.compareTo(a.savedAt));
    }

    // 저장된 순서에 있는 키 우선, 나머지는 알파벳순
    final orderedKeys = <String>[];
    for (final key in _groupOrder) {
      if (map.containsKey(key)) orderedKeys.add(key);
    }
    final newKeys = map.keys.where((k) => !orderedKeys.contains(k)).toList()..sort();
    orderedKeys.addAll(newKeys);

    return {for (final key in orderedKeys) key: map[key]!};
  }

  void _onReorderGroup(int oldIndex, int newIndex) {
    final groups = _groupByPair();
    final keys = groups.keys.toList();
    if (newIndex > oldIndex) newIndex--;
    final item = keys.removeAt(oldIndex);
    keys.insert(newIndex, item);
    setState(() {
      _groupOrder = keys;
    });
    _prefsService.setHistoryGroupOrder(keys);
  }

  Future<void> _deleteRate(int id) async {
    await _historyService.deleteRecord(id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.history),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedRates.isEmpty
              ? _buildEmptyState(theme, l10n)
              : _buildGroupedList(theme, l10n),
    );
  }

  Widget _buildGroupedList(ThemeData theme, AppLocalizations l10n) {
    final groups = _groupByPair();
    final keys = groups.keys.toList();

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: keys.length,
      buildDefaultDragHandles: false,
      proxyDecorator: (child, index, animation) {
        return Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(12),
          child: child,
        );
      },
      onReorder: _onReorderGroup,
      itemBuilder: (context, index) {
        final key = keys[index];
        final rates = groups[key]!;
        final baseCode = rates.first.baseCode;
        final targetCode = rates.first.targetCode;

        final baseCurrencyInfo = Currencies.getByCode(baseCode);
        final targetCurrencyInfo = Currencies.getByCode(targetCode);

        return Column(
          key: ValueKey(key),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 그룹 헤더
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  Text(
                    baseCurrencyInfo?.flag ?? '💱',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    baseCode,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    targetCurrencyInfo?.flag ?? '💱',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    targetCode,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${rates.length}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  if (rates.length >= 2) ...[
                    const SizedBox(width: 4),
                    IconButton(
                      icon: Icon(
                        Icons.show_chart,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () => _showChart(rates, baseCode, targetCode),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      tooltip: l10n.viewChart,
                    ),
                  ],
                  const SizedBox(width: 8),
                  ReorderableDragStartListener(
                    index: index,
                    child: Icon(
                      Icons.drag_handle,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),

            // 그룹 내 기록들
            ...rates.map((rate) => _SavedRateCard(
                  rate: rate,
                  onDelete: () => _showDeleteDialog(rate),
                )),

            if (index < keys.length - 1)
              const Divider(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noSavedRates,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _getEmptyStateHint(context),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getEmptyStateHint(BuildContext context) {
    return AppLocalizations.of(context)!.emptyStateHint;
  }

  Future<void> _showChart(List<SavedRate> rates, String baseCode, String targetCode) async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isPremium = _iapService.isPremium;

    final baseCurrencyInfo = Currencies.getByCode(baseCode);
    final targetCurrencyInfo = Currencies.getByCode(targetCode);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text(l10n.viewChart),
            if (!isPremium) ...[
              const SizedBox(width: 8),
              const AdBadge(),
            ],
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  baseCurrencyInfo?.flag ?? '',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 6),
                Text(
                  baseCode,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  targetCurrencyInfo?.flag ?? '',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(width: 6),
                Text(
                  targetCode,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              l10n.chartDescription(rates.length),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.confirm),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    if (!isPremium) {
      await _adService.showInterstitialAd();
    }

    if (!mounted) return;

    _openChartSheet(rates, baseCode, targetCode);
  }

  void _openChartSheet(List<SavedRate> rates, String baseCode, String targetCode) {
    final baseCurrencyInfo = Currencies.getByCode(baseCode);
    final baseUnit = baseCurrencyInfo?.baseUnit ?? 1;

    // 시간순 정렬 (오래된 것 → 최신)
    final sorted = List<SavedRate>.from(rates)
      ..sort((a, b) => a.savedAt.compareTo(b.savedAt));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _RateChartSheet(
        rates: sorted,
        baseCode: baseCode,
        targetCode: targetCode,
        baseUnit: baseUnit,
      ),
    );
  }

  void _showDeleteDialog(SavedRate rate) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.delete),
        content: Text(
          '${rate.baseCode} → ${rate.targetCode}\n'
          '${rate.rate.toStringAsFixed(4)}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteRate(rate.id);
            },
            child: Text(
              l10n.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedRateCard extends StatelessWidget {
  final SavedRate rate;
  final VoidCallback onDelete;

  const _SavedRateCard({
    required this.rate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final baseCurrencyInfo = Currencies.getByCode(rate.baseCode);
    final baseUnit = baseCurrencyInfo?.baseUnit ?? 1;
    final adjustedRate = rate.rate * baseUnit;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // 날짜/시간
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(rate.savedAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _formatTime(rate.savedAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 16),

            // 환율
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    CurrencyFormatter.formatRate(adjustedRate, rate.targetCode),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${baseUnit == 1 ? '1.00' : CurrencyFormatter.formatWithComma(baseUnit)} ${rate.baseCode}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // 삭제 버튼
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                size: 20,
                color: theme.colorScheme.error.withValues(alpha: 0.7),
              ),
              onPressed: onDelete,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')}';
  }

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

}

class _RateChartSheet extends StatelessWidget {
  final List<SavedRate> rates;
  final String baseCode;
  final String targetCode;
  final int baseUnit;

  const _RateChartSheet({
    required this.rates,
    required this.baseCode,
    required this.targetCode,
    required this.baseUnit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseCurrencyInfo = Currencies.getByCode(baseCode);
    final targetCurrencyInfo = Currencies.getByCode(targetCode);

    final spots = rates.asMap().entries.map((e) {
      final adjusted = e.value.rate * baseUnit;
      return FlSpot(e.key.toDouble(), adjusted);
    }).toList();

    final values = spots.map((s) => s.y).toList();
    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);
    final padding = (maxY - minY) * 0.15;
    final chartMinY = (minY - padding).clamp(0, double.infinity).toDouble();
    final chartMaxY = maxY + padding;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 핸들 바
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  baseCurrencyInfo?.flag ?? '',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 6),
                Text(
                  baseCode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  targetCurrencyInfo?.flag ?? '',
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 6),
                Text(
                  targetCode,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 차트
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  minY: chartMinY,
                  maxY: chartMaxY,
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: (chartMaxY - chartMinY) / 4,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: theme.colorScheme.outline.withValues(alpha: 0.15),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                        interval: _bottomInterval(),
                        getTitlesWidget: (value, meta) {
                          final idx = value.toInt();
                          if (idx < 0 || idx >= rates.length) return const SizedBox.shrink();
                          final dt = rates[idx].savedAt;
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '${dt.month}/${dt.day}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.outline,
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 52,
                        interval: (chartMaxY - chartMinY) / 4,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _formatChartValue(value),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.outline,
                              fontSize: 10,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final idx = spot.x.toInt();
                          final dt = rates[idx].savedAt;
                          final dateStr = '${dt.year}.${dt.month.toString().padLeft(2, '0')}.${dt.day.toString().padLeft(2, '0')}';
                          return LineTooltipItem(
                            '$dateStr\n${_formatChartValue(spot.y)}',
                            TextStyle(
                              color: theme.colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      preventCurveOverShooting: true,
                      color: theme.colorScheme.primary,
                      barWidth: 2.5,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 3.5,
                          color: theme.colorScheme.primary,
                          strokeWidth: 1.5,
                          strokeColor: theme.colorScheme.onPrimary,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 기준 단위 안내
            Text(
              '/ ${baseUnit == 1 ? '1.00' : CurrencyFormatter.formatWithComma(baseUnit)} $baseCode',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _bottomInterval() {
    if (rates.length <= 5) return 1;
    return (rates.length / 4).ceilToDouble();
  }

  String _formatChartValue(double value) {
    if (value >= 1000) {
      return CurrencyFormatter.formatWithComma(value);
    } else if (value >= 100) {
      return value.toStringAsFixed(1);
    } else if (value >= 1) {
      return value.toStringAsFixed(2);
    } else {
      return value.toStringAsFixed(4);
    }
  }
}
