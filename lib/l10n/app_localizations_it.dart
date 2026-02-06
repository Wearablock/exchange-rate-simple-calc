// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Home';

  @override
  String get history => 'Cronologia';

  @override
  String get settings => 'Impostazioni';

  @override
  String get baseCurrency => 'Valuta base';

  @override
  String get targetCurrencies => 'Valute target';

  @override
  String get lastUpdated => 'Ultimo aggiornamento';

  @override
  String minutesAgo(int minutes) {
    return '$minutes min fa';
  }

  @override
  String get justNow => 'Proprio ora';

  @override
  String hoursAgo(int hours) {
    return '$hours ore fa';
  }

  @override
  String get saveRate => 'Salva tasso';

  @override
  String get savedRates => 'Tassi salvati';

  @override
  String get noSavedRates => 'Nessun tasso salvato';

  @override
  String get watchAd => 'Guarda pubblicità per salvare';

  @override
  String get rateSaved => 'Tasso salvato';

  @override
  String get selectBaseCurrency => 'Seleziona la valuta base';

  @override
  String get selectTargetCurrencies => 'Seleziona le valute target';

  @override
  String get getStarted => 'Inizia';

  @override
  String get next => 'Avanti';

  @override
  String get skip => 'Salta';

  @override
  String get refresh => 'Aggiorna';

  @override
  String get addCurrency => 'Aggiungi valuta';

  @override
  String get removeCurrency => 'Rimuovi';

  @override
  String get memo => 'Nota (facoltativo)';

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get delete => 'Elimina';

  @override
  String get confirm => 'Conferma';

  @override
  String get refreshConfirm => 'Vuoi aggiornare i tassi di cambio?';

  @override
  String get language => 'Lingua';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get removeAds => 'Rimuovi pubblicità';

  @override
  String get removeAdsDescription => 'Goditi l\'apprendimento senza pubblicità';

  @override
  String get restorePurchase => 'Ripristina acquisto';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Versione';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfService => 'Termini di servizio';

  @override
  String get support => 'Supporto';

  @override
  String get error => 'Errore';

  @override
  String get retry => 'Riprova';

  @override
  String get noInternet => 'Nessuna connessione Internet';

  @override
  String get loadingFailed => 'Caricamento non riuscito';

  @override
  String get currencySettings => 'Impostazioni valuta';

  @override
  String get appSettings => 'Impostazioni app';

  @override
  String get about => 'Info';

  @override
  String get manageCurrencies => 'Gestisci valute';

  @override
  String get searchCurrency => 'Cerca valuta';

  @override
  String get popular => 'Popolari';

  @override
  String get all => 'Tutte';

  @override
  String get deleteConfirm => 'Sei sicuro di voler eliminare?';

  @override
  String get adRequired => 'È richiesta la visione di una pubblicità';

  @override
  String get adNotReady => 'Pubblicità non ancora pronta';

  @override
  String get saveWithoutAd => 'Salvare senza pubblicità?';

  @override
  String get networkError => 'Controlla la connessione di rete';
}
