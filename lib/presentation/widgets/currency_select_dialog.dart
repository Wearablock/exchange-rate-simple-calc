import 'package:flutter/material.dart';
import '../../core/constants/currencies.dart';
import '../../l10n/app_localizations.dart';

class CurrencySelectDialog extends StatefulWidget {
  final String currentCurrency;
  final String? title;

  const CurrencySelectDialog({
    super.key,
    required this.currentCurrency,
    this.title,
  });

  @override
  State<CurrencySelectDialog> createState() => _CurrencySelectDialogState();
}

class _CurrencySelectDialogState extends State<CurrencySelectDialog> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isKorean = locale.languageCode == 'ko';

    final filteredCurrencies = Currencies.all.where((c) {
      if (_searchQuery.isEmpty) return true;
      final lowerQuery = _searchQuery.toLowerCase();
      return c.code.toLowerCase().contains(lowerQuery) ||
          c.name.toLowerCase().contains(lowerQuery) ||
          c.nameKo.contains(_searchQuery);
    }).toList();

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.title ?? l10n.baseCurrency,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            // 검색
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchCurrency,
                  prefixIcon: const Icon(Icons.search),
                  isDense: true,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 8),

            // 통화 목록
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filteredCurrencies.length,
                itemBuilder: (context, index) {
                  final currency = filteredCurrencies[index];
                  final isSelected = currency.code == widget.currentCurrency;

                  return ListTile(
                    leading: Text(
                      currency.flag,
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text(currency.code),
                    subtitle: Text(isKorean ? currency.nameKo : currency.name),
                    trailing: isSelected
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).colorScheme.primary,
                          )
                        : null,
                    selected: isSelected,
                    onTap: () => Navigator.pop(context, currency.code),
                  );
                },
              ),
            ),

            // 취소 버튼
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.cancel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
