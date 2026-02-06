// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Главная';

  @override
  String get history => 'История';

  @override
  String get settings => 'Настройки';

  @override
  String get baseCurrency => 'Базовая валюта';

  @override
  String get targetCurrencies => 'Целевые валюты';

  @override
  String get lastUpdated => 'Последнее обновление';

  @override
  String minutesAgo(int minutes) {
    return '$minutes мин. назад';
  }

  @override
  String get justNow => 'Только что';

  @override
  String hoursAgo(int hours) {
    return '$hours ч. назад';
  }

  @override
  String get saveRate => 'Сохранить курс';

  @override
  String get savedRates => 'Сохранённые курсы';

  @override
  String get noSavedRates => 'Нет сохранённых курсов';

  @override
  String get watchAd => 'Посмотреть рекламу для сохранения';

  @override
  String get rateSaved => 'Курс сохранён';

  @override
  String get selectBaseCurrency => 'Выберите базовую валюту';

  @override
  String get selectTargetCurrencies => 'Выберите целевые валюты';

  @override
  String get getStarted => 'Начать';

  @override
  String get next => 'Далее';

  @override
  String get skip => 'Пропустить';

  @override
  String get refresh => 'Обновить';

  @override
  String get addCurrency => 'Добавить валюту';

  @override
  String get removeCurrency => 'Удалить';

  @override
  String get memo => 'Заметка (необязательно)';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get delete => 'Удалить';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get refreshConfirm => 'Обновить курсы валют?';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get removeAds => 'Убрать рекламу';

  @override
  String get removeAdsDescription => 'Наслаждайтесь обучением без рекламы';

  @override
  String get restorePurchase => 'Восстановить покупку';

  @override
  String get premium => 'Премиум';

  @override
  String get version => 'Версия';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get support => 'Поддержка';

  @override
  String get error => 'Ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get noInternet => 'Нет подключения к интернету';

  @override
  String get loadingFailed => 'Ошибка загрузки';

  @override
  String get currencySettings => 'Настройки валюты';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get about => 'О приложении';

  @override
  String get manageCurrencies => 'Управление валютами';

  @override
  String get searchCurrency => 'Поиск валюты';

  @override
  String get popular => 'Популярные';

  @override
  String get all => 'Все';

  @override
  String get deleteConfirm => 'Вы уверены, что хотите удалить?';

  @override
  String get adRequired => 'Требуется просмотр рекламы';

  @override
  String get adNotReady => 'Реклама ещё не готова';

  @override
  String get saveWithoutAd => 'Сохранить без рекламы?';

  @override
  String get networkError => 'Проверьте подключение к сети';

  @override
  String get saveRateDescription => 'Сохранить текущий курс для справки';

  @override
  String get viewChart => 'Посмотреть график';

  @override
  String chartDescription(int count) {
    return 'Просмотр тренда курса по $count записям';
  }

  @override
  String get selectLanguage => 'Выбор языка';

  @override
  String get systemDefault => 'Системный по умолчанию';
}
