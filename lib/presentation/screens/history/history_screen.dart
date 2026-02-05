import 'package:flutter/material.dart';
import '../../../core/services/rate_history_service.dart';
import '../../../core/constants/currencies.dart';
import '../../../data/database/app_database.dart';
import '../../../l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final RateHistoryService _historyService = RateHistoryService();
  List<SavedRate> _savedRates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedRates();
  }

  Future<void> _loadSavedRates() async {
    setState(() => _isLoading = true);
    try {
      final rates = await _historyService.getAllRecords();
      setState(() {
        _savedRates = rates;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteRate(int id) async {
    await _historyService.deleteRecord(id);
    await _loadSavedRates();
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
              : RefreshIndicator(
                  onRefresh: _loadSavedRates,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _savedRates.length,
                    itemBuilder: (context, index) {
                      final rate = _savedRates[index];
                      return _SavedRateCard(
                        rate: rate,
                        onDelete: () => _showDeleteDialog(rate),
                      );
                    },
                  ),
                ),
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
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'ko':
        return '홈 화면에서 환율을 저장해보세요';
      case 'ja':
        return 'ホーム画面で為替レートを保存してみてください';
      case 'zh':
        return '在主页保存汇率';
      default:
        return 'Save exchange rates from the home screen';
    }
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
    final targetCurrencyInfo = Currencies.getByCode(rate.targetCode);

    // 기준 통화의 baseUnit 적용
    final baseUnit = baseCurrencyInfo?.baseUnit ?? 1;
    final adjustedRate = rate.rate * baseUnit;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더: 날짜 및 삭제 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDateTime(rate.savedAt),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: theme.colorScheme.error,
                  ),
                  onPressed: onDelete,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 환율 정보
            Row(
              children: [
                // 기준 통화
                Expanded(
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
                            rate.baseCode,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formatBaseUnit(baseUnit),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 화살표
                Icon(
                  Icons.arrow_forward,
                  color: theme.colorScheme.primary,
                ),

                // 대상 통화
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            rate.targetCode,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _formatRate(adjustedRate, rate.targetCode),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        targetCurrencyInfo?.flag ?? '💱',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 메모가 있는 경우
            if (rate.memo != null && rate.memo!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  rate.memo!,
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.day.toString().padLeft(2, '0')} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatBaseUnit(int baseUnit) {
    if (baseUnit == 1) {
      return '1.00';
    }
    return _formatWithComma(baseUnit);
  }

  String _formatRate(double rate, String targetCurrency) {
    final decimalPlaces = Currencies.getDecimalPlaces(targetCurrency);

    if (decimalPlaces == 0) {
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
