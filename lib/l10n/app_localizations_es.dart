// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Inicio';

  @override
  String get history => 'Historial';

  @override
  String get settings => 'Ajustes';

  @override
  String get baseCurrency => 'Moneda base';

  @override
  String get targetCurrencies => 'Monedas objetivo';

  @override
  String get lastUpdated => 'Última actualización';

  @override
  String minutesAgo(int minutes) {
    return 'hace $minutes min';
  }

  @override
  String get justNow => 'Ahora mismo';

  @override
  String hoursAgo(int hours) {
    return 'hace $hours h';
  }

  @override
  String get saveRate => 'Guardar tipo';

  @override
  String get savedRates => 'Tipos guardados';

  @override
  String get noSavedRates => 'No hay tipos guardados';

  @override
  String get watchAd => 'Ver anuncio para guardar';

  @override
  String get rateSaved => 'Tipo guardado';

  @override
  String get selectBaseCurrency => 'Selecciona la moneda base';

  @override
  String get selectTargetCurrencies => 'Selecciona las monedas objetivo';

  @override
  String get getStarted => 'Empezar';

  @override
  String get next => 'Siguiente';

  @override
  String get skip => 'Omitir';

  @override
  String get refresh => 'Actualizar';

  @override
  String get addCurrency => 'Añadir moneda';

  @override
  String get removeCurrency => 'Eliminar';

  @override
  String get memo => 'Nota (opcional)';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get refreshConfirm => '¿Desea actualizar los tipos de cambio?';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get removeAds => 'Eliminar anuncios';

  @override
  String get removeAdsDescription => 'Disfruta sin anuncios para siempre';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Versión';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get support => 'Soporte';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Reintentar';

  @override
  String get noInternet => 'Sin conexión a Internet';

  @override
  String get loadingFailed => 'Error al cargar';

  @override
  String get currencySettings => 'Ajustes de moneda';

  @override
  String get appSettings => 'Ajustes de la app';

  @override
  String get about => 'Acerca de';

  @override
  String get manageCurrencies => 'Gestionar monedas';

  @override
  String get searchCurrency => 'Buscar moneda';

  @override
  String get popular => 'Populares';

  @override
  String get all => 'Todas';

  @override
  String get deleteConfirm => '¿Seguro que quieres eliminar?';

  @override
  String get adRequired => 'Se requiere ver anuncio';

  @override
  String get adNotReady => 'Anuncio no disponible aún';

  @override
  String get saveWithoutAd => '¿Guardar sin ver anuncio?';

  @override
  String get networkError => 'Comprueba tu conexión de red';

  @override
  String get saveRateDescription =>
      'Guardar el tipo de cambio actual para consulta futura';

  @override
  String get viewChart => 'Ver gráfico';

  @override
  String chartDescription(int count) {
    return 'Ver tendencia del tipo de cambio con $count registros';
  }

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get systemDefault => 'Predeterminado del sistema';
}
