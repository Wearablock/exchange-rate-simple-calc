import 'package:flutter/material.dart';
import '../../../../core/constants/currencies.dart';
import '../../../../data/models/currency.dart';
import '../../../../l10n/app_localizations.dart';

class TargetCurrencyPage extends StatefulWidget {
  final String baseCurrency;
  final List<String> selectedCurrencies;
  final ValueChanged<List<String>> onCurrenciesChanged;
  final VoidCallback onComplete;

  const TargetCurrencyPage({
    super.key,
    required this.baseCurrency,
    required this.selectedCurrencies,
    required this.onCurrenciesChanged,
    required this.onComplete,
  });

  @override
  State<TargetCurrencyPage> createState() => _TargetCurrencyPageState();
}

class _TargetCurrencyPageState extends State<TargetCurrencyPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Currency> get _filteredCurrencies {
    // 기준 통화 제외
    final currencies = Currencies.all
        .where((c) => c.code != widget.baseCurrency)
        .toList();

    if (_searchQuery.isEmpty) {
      return currencies;
    }

    final lowerQuery = _searchQuery.toLowerCase();
    return currencies.where((c) =>
        c.code.toLowerCase().contains(lowerQuery) ||
        c.name.toLowerCase().contains(lowerQuery) ||
        c.nameKo.contains(_searchQuery)).toList();
  }

  void _toggleCurrency(String code) {
    final newList = List<String>.from(widget.selectedCurrencies);
    if (newList.contains(code)) {
      newList.remove(code);
    } else {
      newList.add(code);
    }
    widget.onCurrenciesChanged(newList);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // 기준 통화 제외한 선택 목록
    final selectedCount = widget.selectedCurrencies
        .where((c) => c != widget.baseCurrency)
        .length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // 타이틀
          Text(
            l10n.selectTargetCurrencies,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.targetCurrencyDescription,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  l10n.selectedCount(selectedCount),
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 검색
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: l10n.searchCurrency,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),

          const SizedBox(height: 16),

          // 통화 목록
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCurrencies.length,
              itemBuilder: (context, index) {
                final currency = _filteredCurrencies[index];
                final isSelected = widget.selectedCurrencies.contains(currency.code);

                return _CurrencyCheckTile(
                  currency: currency,
                  isSelected: isSelected,
                  onTap: () => _toggleCurrency(currency.code),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 완료 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedCount > 0 ? widget.onComplete : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  l10n.getStarted,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

}

class _CurrencyCheckTile extends StatelessWidget {
  final Currency currency;
  final bool isSelected;
  final VoidCallback onTap;

  const _CurrencyCheckTile({
    required this.currency,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final isKorean = locale.languageCode == 'ko';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.colorScheme.primary.withValues(alpha: 0.1)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withValues(alpha: 0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Text(
          currency.flag,
          style: const TextStyle(fontSize: 28),
        ),
        title: Text(
          currency.code,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? theme.colorScheme.primary : null,
          ),
        ),
        subtitle: Text(
          isKorean ? currency.nameKo : currency.name,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (_) => onTap(),
          activeColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
