// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Startseite';

  @override
  String get history => 'Verlauf';

  @override
  String get settings => 'Einstellungen';

  @override
  String get baseCurrency => 'Basiswährung';

  @override
  String get targetCurrencies => 'Zielwährungen';

  @override
  String get lastUpdated => 'Zuletzt aktualisiert';

  @override
  String minutesAgo(int minutes) {
    return 'vor $minutes Min.';
  }

  @override
  String get justNow => 'Gerade eben';

  @override
  String hoursAgo(int hours) {
    return 'vor $hours Std.';
  }

  @override
  String get saveRate => 'Kurs speichern';

  @override
  String get savedRates => 'Gespeicherte Kurse';

  @override
  String get noSavedRates => 'Keine gespeicherten Kurse';

  @override
  String get watchAd => 'Werbung ansehen zum Speichern';

  @override
  String get rateSaved => 'Kurs gespeichert';

  @override
  String get selectBaseCurrency => 'Basiswährung auswählen';

  @override
  String get selectTargetCurrencies => 'Zielwährungen auswählen';

  @override
  String get getStarted => 'Starten';

  @override
  String get next => 'Weiter';

  @override
  String get skip => 'Überspringen';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get addCurrency => 'Währung hinzufügen';

  @override
  String get removeCurrency => 'Entfernen';

  @override
  String get memo => 'Notiz (optional)';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get language => 'Sprache';

  @override
  String get theme => 'Design';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get removeAds => 'Werbung entfernen';

  @override
  String get removeAdsDescription => 'Genieße werbefreies Lernen für immer';

  @override
  String get restorePurchase => 'Kauf wiederherstellen';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get support => 'Support';

  @override
  String get error => 'Fehler';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get noInternet => 'Keine Internetverbindung';

  @override
  String get loadingFailed => 'Laden fehlgeschlagen';

  @override
  String get currencySettings => 'Währungseinstellungen';

  @override
  String get appSettings => 'App-Einstellungen';

  @override
  String get about => 'Über';

  @override
  String get manageCurrencies => 'Währungen verwalten';

  @override
  String get searchCurrency => 'Währung suchen';

  @override
  String get popular => 'Beliebt';

  @override
  String get all => 'Alle';

  @override
  String get deleteConfirm => 'Wirklich löschen?';

  @override
  String get adRequired => 'Werbung ansehen erforderlich';

  @override
  String get adNotReady => 'Werbung noch nicht bereit';

  @override
  String get saveWithoutAd => 'Ohne Werbung speichern?';

  @override
  String get networkError => 'Bitte Netzwerkverbindung prüfen';
}
