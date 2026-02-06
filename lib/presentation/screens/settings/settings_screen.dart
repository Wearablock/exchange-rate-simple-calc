import 'package:flutter/material.dart';
import '../../../core/config/app_config.dart';
import '../../../core/constants/currencies.dart';
import '../../../core/services/preferences_service.dart';
import '../../../core/services/iap_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../main.dart';
import '../../widgets/currency_select_dialog.dart';
import 'webview_screen.dart';

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
  String? _languageCode;
  bool _isPremium = false;

  static const Map<String?, String> _languageNativeNames = {
    'en': 'English',
    'ko': '한국어',
    'ja': '日本語',
    'zh': '简体中文',
    'zh_Hant': '繁體中文',
    'de': 'Deutsch',
    'fr': 'Français',
    'es': 'Español',
    'pt': 'Português',
    'it': 'Italiano',
    'ru': 'Русский',
    'ar': 'العربية',
    'th': 'ไทย',
    'vi': 'Tiếng Việt',
    'id': 'Bahasa Indonesia',
  };

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    setState(() {
      _baseCurrency = _prefsService.baseCurrency;
      _themeMode = _prefsService.themeMode;
      _languageCode = _prefsService.languageCode;
      _isPremium = _iapService.isPremium;
    });
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
      if (mounted) {
        EasyExchangeApp.setThemeMode(context, result);
      }
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

  Future<void> _changeLanguage() async {
    final l10n = AppLocalizations.of(context)!;

    // Use sentinel to distinguish "system default" from dialog dismissal
    const systemSentinel = '_system_';
    final result = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(l10n.selectLanguage),
        children: [
          _buildLanguageOption(systemSentinel, l10n.systemDefault, _languageCode == null),
          ..._languageNativeNames.entries.map(
            (e) => _buildLanguageOption(e.key!, e.value, _languageCode == e.key),
          ),
        ],
      ),
    );

    if (result == null) return; // dialog dismissed

    final newCode = result == systemSentinel ? null : result;
    if (newCode == _languageCode) return;

    await _prefsService.setLanguageCode(newCode);
    setState(() {
      _languageCode = newCode;
    });
    if (mounted) {
      EasyExchangeApp.setLocale(context, newCode);
    }
  }

  Widget _buildLanguageOption(String value, String label, bool isSelected) {
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

  void _openWebView(String title, String baseUrl) {
    // Determine language code for the HTML page
    String? langCode = _prefsService.languageCode;
    if (langCode == null) {
      final locale = Localizations.localeOf(context);
      if (locale.scriptCode == 'Hant') {
        langCode = 'zh-TW';
      } else {
        langCode = locale.languageCode;
      }
    } else if (langCode == 'zh_Hant') {
      langCode = 'zh-TW';
    }

    final url = '$baseUrl?lang=$langCode';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: title,
          url: url,
        ),
      ),
    );
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

          // 언어
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.language),
            subtitle: Text(_getLanguageLabel(l10n)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _changeLanguage,
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
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openWebView(l10n.privacyPolicy, AppConfig.privacyUrl),
          ),

          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: Text(l10n.termsOfService),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openWebView(l10n.termsOfService, AppConfig.termsUrl),
          ),

          ListTile(
            leading: const Icon(Icons.help_outline),
            title: Text(l10n.support),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openWebView(l10n.support, AppConfig.supportUrl),
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

  String _getLanguageLabel(AppLocalizations l10n) {
    if (_languageCode == null) return l10n.systemDefault;
    return _languageNativeNames[_languageCode] ?? _languageCode!;
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

