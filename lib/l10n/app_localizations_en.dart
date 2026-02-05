// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Home';

  @override
  String get history => 'History';

  @override
  String get settings => 'Settings';

  @override
  String get baseCurrency => 'Base Currency';

  @override
  String get targetCurrencies => 'Target Currencies';

  @override
  String get lastUpdated => 'Last updated';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min ago';
  }

  @override
  String get justNow => 'Just now';

  @override
  String hoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String get saveRate => 'Save Rate';

  @override
  String get savedRates => 'Saved Rates';

  @override
  String get noSavedRates => 'No saved rates yet';

  @override
  String get watchAd => 'Watch ad to save';

  @override
  String get rateSaved => 'Rate saved successfully';

  @override
  String get selectBaseCurrency => 'Select your base currency';

  @override
  String get selectTargetCurrencies => 'Select currencies to watch';

  @override
  String get getStarted => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get refresh => 'Refresh';

  @override
  String get addCurrency => 'Add Currency';

  @override
  String get removeCurrency => 'Remove';

  @override
  String get memo => 'Memo (optional)';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get removeAds => 'Remove Ads';

  @override
  String get removeAdsDescription =>
      'Enjoy ad-free learning experience forever';

  @override
  String get restorePurchase => 'Restore Purchase';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get support => 'Support';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get noInternet => 'No internet connection';

  @override
  String get loadingFailed => 'Failed to load data';

  @override
  String get currencySettings => 'Currency Settings';

  @override
  String get appSettings => 'App Settings';

  @override
  String get about => 'About';

  @override
  String get manageCurrencies => 'Manage Currencies';

  @override
  String get searchCurrency => 'Search currency';

  @override
  String get popular => 'Popular';

  @override
  String get all => 'All';

  @override
  String get deleteConfirm => 'Are you sure you want to delete?';

  @override
  String get adRequired => 'Ad viewing required';

  @override
  String get adNotReady => 'Ad is not ready yet';

  @override
  String get saveWithoutAd => 'Save without watching ad?';

  @override
  String get networkError => 'Please check your network connection';
}
