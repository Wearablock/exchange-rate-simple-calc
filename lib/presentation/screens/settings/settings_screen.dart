import 'package:flutter/material.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/services/preferences_service.dart';
import '../../../core/services/iap_service.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final PreferencesService _prefsService = PreferencesService();
  final IAPService _iapService = IAPService();

  String _baseCurrency = 'USD';
  String _themeMode = 'system';
  bool _isPremium = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _baseCurrency = _prefsService.baseCurrency;
      _themeMode = _prefsService.themeMode;
      _isPremium = _iapService.isPremium;
    });
  }

  Future<void> _changeBaseCurrency() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => _CurrencySelectDialog(
        currentCurrency: _baseCurrency,
      ),
    );

    if (result != null && result != _baseCurrency) {
      await _prefsService.setBaseCurrency(result);
      setState(() {
        _baseCurrency = result;
      });
    }
  }

  Future<void> _changeTheme() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.theme),
        children: [
          _buildThemeOption('system', l10n.themeSystem),
          _buildThemeOption('light', l10n.themeLight),
          _buildThemeOption('dark', l10n.themeDark),
        ],
      ),
    );

    if (result != null && result != _themeMode) {
      await _prefsService.setThemeMode(result);
      setState(() {
        _themeMode = result;
      });
      // TODO: 앱 전체 테마 변경 적용
    }
  }

  Widget _buildThemeOption(String value, String label) {
    final isSelected = _themeMode == value;
    return SimpleDialogOption(
      onPressed: () => Navigator.pop(context, value),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isSelected ? Theme.of(context).colorScheme.primary : null,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }

  Future<void> _purchaseAdFree() async {
    final l10n = AppLocalizations.of(context)!;

    // 구매 진행
    final success = await _iapService.buyRemoveAds();

    if (mounted) {
      if (success) {
        setState(() {
          _isPremium = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.rateSaved)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.loadingFailed)),
        );
      }
    }
  }

  Future<void> _restorePurchase() async {
    final l10n = AppLocalizations.of(context)!;

    await _iapService.restorePurchases();

    if (mounted) {
      setState(() {
        _isPremium = _iapService.isPremium;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.restorePurchase)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final baseCurrencyInfo = Currencies.getByCode(_baseCurrency);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // 일반 설정 섹션
          _buildSectionHeader(l10n.appSettings),

          // 기준 통화
          ListTile(
            leading: const Icon(Icons.currency_exchange),
            title: Text(l10n.baseCurrency),
            subtitle: Text('${baseCurrencyInfo?.flag ?? ''} $_baseCurrency'),
            trailing: const Icon(Icons.chevron_right),
            onTap: _changeBaseCurrency,
          ),

          // 테마
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(l10n.theme),
            subtitle: Text(_getThemeLabel(l10n)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _changeTheme,
          ),

          const Divider(),

          // 광고 제거 섹션
          _buildSectionHeader(l10n.removeAds),

          if (_isPremium)
            ListTile(
              leading: Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              ),
              title: Text(l10n.premium),
              subtitle: Text(_getAdFreeDescription(context)),
            )
          else ...[
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: Text(l10n.removeAds),
              subtitle: Text(_getPurchaseDescription(context)),
              trailing: const Icon(Icons.chevron_right),
              onTap: _purchaseAdFree,
            ),
            ListTile(
              leading: const Icon(Icons.restore),
              title: Text(l10n.restorePurchase),
              onTap: _restorePurchase,
            ),
          ],

          const Divider(),

          // 앱 정보 섹션
          _buildSectionHeader(l10n.about),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(l10n.version),
            subtitle: const Text('1.0.0'),
          ),

          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: Text(l10n.privacyPolicy),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // TODO: 개인정보처리방침 URL 열기
            },
          ),

          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(l10n.termsOfService),
            trailing: const Icon(Icons.open_in_new),
            onTap: () {
              // TODO: 이용약관 URL 열기
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getThemeLabel(AppLocalizations l10n) {
    switch (_themeMode) {
      case 'light':
        return l10n.themeLight;
      case 'dark':
        return l10n.themeDark;
      default:
        return l10n.themeSystem;
    }
  }

  String _getAdFreeDescription(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'ko':
        return '모든 광고가 제거되었습니다';
      case 'ja':
        return 'すべての広告が削除されました';
      case 'zh':
        return '所有广告已移除';
      default:
        return 'All ads have been removed';
    }
  }

  String _getPurchaseDescription(BuildContext context) {
    final locale = Localizations.localeOf(context);

    switch (locale.languageCode) {
      case 'ko':
        return '일회성 구매로 모든 광고 제거';
      case 'ja':
        return '一度の購入ですべての広告を削除';
      case 'zh':
        return '一次性购买移除所有广告';
      default:
        return 'One-time purchase to remove all ads';
    }
  }
}

class _CurrencySelectDialog extends StatefulWidget {
  final String currentCurrency;

  const _CurrencySelectDialog({
    required this.currentCurrency,
  });

  @override
  State<_CurrencySelectDialog> createState() => _CurrencySelectDialogState();
}

class _CurrencySelectDialogState extends State<_CurrencySelectDialog> {
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
                l10n.baseCurrency,
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
