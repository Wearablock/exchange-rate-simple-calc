// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Início';

  @override
  String get history => 'Histórico';

  @override
  String get settings => 'Configurações';

  @override
  String get baseCurrency => 'Moeda base';

  @override
  String get targetCurrencies => 'Moedas alvo';

  @override
  String get lastUpdated => 'Última atualização';

  @override
  String minutesAgo(int minutes) {
    return 'há $minutes min';
  }

  @override
  String get justNow => 'Agora mesmo';

  @override
  String hoursAgo(int hours) {
    return 'há $hours h';
  }

  @override
  String get saveRate => 'Salvar taxa';

  @override
  String get savedRates => 'Taxas salvas';

  @override
  String get noSavedRates => 'Nenhuma taxa salva';

  @override
  String get watchAd => 'Assistir anúncio para salvar';

  @override
  String get rateSaved => 'Taxa salva';

  @override
  String get selectBaseCurrency => 'Selecione a moeda base';

  @override
  String get selectTargetCurrencies => 'Selecione as moedas alvo';

  @override
  String get getStarted => 'Começar';

  @override
  String get next => 'Próximo';

  @override
  String get skip => 'Pular';

  @override
  String get refresh => 'Atualizar';

  @override
  String get addCurrency => 'Adicionar moeda';

  @override
  String get removeCurrency => 'Remover';

  @override
  String get memo => 'Nota (opcional)';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get delete => 'Excluir';

  @override
  String get confirm => 'Confirmar';

  @override
  String get refreshConfirm => 'Deseja atualizar as taxas de câmbio?';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get removeAds => 'Remover anúncios';

  @override
  String get removeAdsDescription => 'Aproveite o aprendizado sem anúncios';

  @override
  String get restorePurchase => 'Restaurar compra';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Versão';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get termsOfService => 'Termos de serviço';

  @override
  String get support => 'Suporte';

  @override
  String get error => 'Erro';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get noInternet => 'Sem conexão com a Internet';

  @override
  String get loadingFailed => 'Falha ao carregar';

  @override
  String get currencySettings => 'Configurações de moeda';

  @override
  String get appSettings => 'Configurações do app';

  @override
  String get about => 'Sobre';

  @override
  String get manageCurrencies => 'Gerenciar moedas';

  @override
  String get searchCurrency => 'Pesquisar moeda';

  @override
  String get popular => 'Populares';

  @override
  String get all => 'Todas';

  @override
  String get deleteConfirm => 'Tem certeza que deseja excluir?';

  @override
  String get adRequired => 'É necessário assistir anúncio';

  @override
  String get adNotReady => 'Anúncio ainda não disponível';

  @override
  String get saveWithoutAd => 'Salvar sem assistir anúncio?';

  @override
  String get networkError => 'Verifique sua conexão de rede';

  @override
  String get saveRateDescription =>
      'Salvar a taxa de câmbio atual para consulta futura';

  @override
  String get viewChart => 'Ver gráfico';

  @override
  String chartDescription(int count) {
    return 'Ver tendência da taxa de câmbio com $count registros';
  }

  @override
  String get selectLanguage => 'Selecionar idioma';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get welcomeDescription =>
      'Confira taxas de câmbio em tempo real\ne salve as taxas importantes';

  @override
  String get baseCurrencyDescription =>
      'Selecione a moeda para comparação de taxas';

  @override
  String get targetCurrencyDescription =>
      'Selecione as moedas que deseja acompanhar';

  @override
  String selectedCount(int count) {
    return '$count selecionada(s)';
  }

  @override
  String get emptyStateHint => 'Salve taxas de câmbio na tela inicial';

  @override
  String get adFreeActivated => 'Todos os anúncios foram removidos';

  @override
  String get adFreePurchaseDescription =>
      'Compra única para remover todos os anúncios';

  @override
  String get noCurrencies => 'Nenhuma moeda para exibir';

  @override
  String get purchaseSuccess => 'Compra realizada com sucesso';

  @override
  String get purchaseFailed => 'Falha na compra. Tente novamente.';
}
