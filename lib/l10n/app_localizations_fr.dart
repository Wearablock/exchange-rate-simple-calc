// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Accueil';

  @override
  String get history => 'Historique';

  @override
  String get settings => 'Paramètres';

  @override
  String get baseCurrency => 'Devise de base';

  @override
  String get targetCurrencies => 'Devises cibles';

  @override
  String get lastUpdated => 'Dernière mise à jour';

  @override
  String minutesAgo(int minutes) {
    return 'il y a $minutes min';
  }

  @override
  String get justNow => 'À l\'instant';

  @override
  String hoursAgo(int hours) {
    return 'il y a $hours h';
  }

  @override
  String get saveRate => 'Enregistrer le taux';

  @override
  String get savedRates => 'Taux enregistrés';

  @override
  String get noSavedRates => 'Aucun taux enregistré';

  @override
  String get watchAd => 'Regarder une pub pour enregistrer';

  @override
  String get rateSaved => 'Taux enregistré';

  @override
  String get selectBaseCurrency => 'Sélectionnez la devise de base';

  @override
  String get selectTargetCurrencies => 'Sélectionnez les devises cibles';

  @override
  String get getStarted => 'Commencer';

  @override
  String get next => 'Suivant';

  @override
  String get skip => 'Passer';

  @override
  String get refresh => 'Actualiser';

  @override
  String get addCurrency => 'Ajouter une devise';

  @override
  String get removeCurrency => 'Supprimer';

  @override
  String get memo => 'Note (facultatif)';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get language => 'Langue';

  @override
  String get theme => 'Thème';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get removeAds => 'Supprimer les pubs';

  @override
  String get removeAdsDescription => 'Profitez d\'un apprentissage sans pub';

  @override
  String get restorePurchase => 'Restaurer l\'achat';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Version';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfService => 'Conditions d\'utilisation';

  @override
  String get support => 'Assistance';

  @override
  String get error => 'Erreur';

  @override
  String get retry => 'Réessayer';

  @override
  String get noInternet => 'Pas de connexion Internet';

  @override
  String get loadingFailed => 'Échec du chargement';

  @override
  String get currencySettings => 'Paramètres de devise';

  @override
  String get appSettings => 'Paramètres de l\'app';

  @override
  String get about => 'À propos';

  @override
  String get manageCurrencies => 'Gérer les devises';

  @override
  String get searchCurrency => 'Rechercher une devise';

  @override
  String get popular => 'Populaires';

  @override
  String get all => 'Toutes';

  @override
  String get deleteConfirm => 'Voulez-vous vraiment supprimer ?';

  @override
  String get adRequired => 'Visionnage de pub requis';

  @override
  String get adNotReady => 'Pub pas encore prête';

  @override
  String get saveWithoutAd => 'Enregistrer sans pub ?';

  @override
  String get networkError => 'Vérifiez votre connexion réseau';
}
