import 'package:flutter/material.dart';
import '../../../../core/constants/currencies.dart';
import '../../../../data/models/currency.dart';
import '../../../../l10n/app_localizations.dart';

class BaseCurrencyPage extends StatefulWidget {
  final String selectedCurrency;
  final ValueChanged<String> onCurrencySelected;
  final VoidCallback onNext;

  const BaseCurrencyPage({
    super.key,
    required this.selectedCurrency,
    required this.onCurrencySelected,
    required this.onNext,
  });

  @override
  State<BaseCurrencyPage> createState() => _BaseCurrencyPageState();
}

class _BaseCurrencyPageState extends State<BaseCurrencyPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Currency> get _filteredCurrencies {
    if (_searchQuery.isEmpty) {
      // 인기 통화 먼저 표시
      final popular = Currencies.popularCurrencies
          .map((code) => Currencies.getByCode(code))
          .whereType<Currency>()
          .toList();
      final others = Currencies.all
          .where((c) => !Currencies.popularCurrencies.contains(c.code))
          .toList();
      return [...popular, ...others];
    }
    return Currencies.search(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),

          // 타이틀
          Text(
            l10n.selectBaseCurrency,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            l10n.baseCurrencyDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
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
                final isSelected = currency.code == widget.selectedCurrency;
                final isPopular = Currencies.popularCurrencies.contains(currency.code);

                return _CurrencyTile(
                  currency: currency,
                  isSelected: isSelected,
                  isPopular: isPopular && _searchQuery.isEmpty && index < Currencies.popularCurrencies.length,
                  onTap: () {
                    widget.onCurrencySelected(currency.code);
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 다음 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.onNext,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  l10n.next,
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

class _CurrencyTile extends StatelessWidget {
  final Currency currency;
  final bool isSelected;
  final bool isPopular;
  final VoidCallback onTap;

  const _CurrencyTile({
    required this.currency,
    required this.isSelected,
    required this.isPopular,
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
        title: Row(
          children: [
            Text(
              currency.code,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? theme.colorScheme.primary : null,
              ),
            ),
            if (isPopular) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    fontSize: 10,
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          isKorean ? currency.nameKo : currency.name,
          style: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              )
            : null,
      ),
    );
  }
}
