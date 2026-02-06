// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'ホーム';

  @override
  String get history => '履歴';

  @override
  String get settings => '設定';

  @override
  String get baseCurrency => '基準通貨';

  @override
  String get targetCurrencies => '対象通貨';

  @override
  String get lastUpdated => '最終更新';

  @override
  String minutesAgo(int minutes) {
    return '$minutes分前';
  }

  @override
  String get justNow => 'たった今';

  @override
  String hoursAgo(int hours) {
    return '$hours時間前';
  }

  @override
  String get saveRate => '為替レートを保存';

  @override
  String get savedRates => '保存されたレート';

  @override
  String get noSavedRates => '保存されたレートはありません';

  @override
  String get watchAd => '広告を見て保存';

  @override
  String get rateSaved => 'レートが保存されました';

  @override
  String get selectBaseCurrency => '基準通貨を選択してください';

  @override
  String get selectTargetCurrencies => '対象通貨を選択してください';

  @override
  String get getStarted => '始める';

  @override
  String get next => '次へ';

  @override
  String get skip => 'スキップ';

  @override
  String get refresh => '更新';

  @override
  String get addCurrency => '通貨を追加';

  @override
  String get removeCurrency => '削除';

  @override
  String get memo => 'メモ（任意）';

  @override
  String get cancel => 'キャンセル';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get confirm => '確認';

  @override
  String get refreshConfirm => '為替レートを更新しますか？';

  @override
  String get language => '言語';

  @override
  String get theme => 'テーマ';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeDark => 'ダーク';

  @override
  String get removeAds => '広告を削除';

  @override
  String get removeAdsDescription => 'すべての広告を永久に削除します';

  @override
  String get restorePurchase => '購入を復元';

  @override
  String get premium => 'プレミアム';

  @override
  String get version => 'バージョン';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfService => '利用規約';

  @override
  String get support => 'サポート';

  @override
  String get error => 'エラー';

  @override
  String get retry => '再試行';

  @override
  String get noInternet => 'インターネット接続がありません';

  @override
  String get loadingFailed => 'データの読み込みに失敗しました';

  @override
  String get currencySettings => '通貨設定';

  @override
  String get appSettings => 'アプリ設定';

  @override
  String get about => '情報';

  @override
  String get manageCurrencies => '通貨を管理';

  @override
  String get searchCurrency => '通貨を検索';

  @override
  String get popular => '人気';

  @override
  String get all => 'すべて';

  @override
  String get deleteConfirm => '本当に削除しますか？';

  @override
  String get adRequired => '広告の視聴が必要です';

  @override
  String get adNotReady => '広告の準備ができていません';

  @override
  String get saveWithoutAd => '広告なしで保存しますか？';

  @override
  String get networkError => 'ネットワーク接続を確認してください';

  @override
  String get saveRateDescription => '現在の為替レートを記録として保存します';

  @override
  String get viewChart => 'グラフを見る';

  @override
  String chartDescription(int count) {
    return '$count件の記録で為替レートの推移を確認します';
  }

  @override
  String get selectLanguage => '言語選択';

  @override
  String get systemDefault => 'システムデフォルト';

  @override
  String get welcomeDescription => 'リアルタイム為替レートを確認し\n重要な為替レートを記録しましょう';

  @override
  String get baseCurrencyDescription => '為替レート比較の基準となる通貨を選択してください';

  @override
  String get targetCurrencyDescription => '関心のある通貨を選択してください';

  @override
  String selectedCount(int count) {
    return '$count件選択中';
  }

  @override
  String get emptyStateHint => 'ホーム画面で為替レートを保存してみてください';

  @override
  String get adFreeActivated => 'すべての広告が削除されました';

  @override
  String get adFreePurchaseDescription => '一度の購入ですべての広告を削除';

  @override
  String get noCurrencies => '表示する通貨がありません';

  @override
  String get purchaseSuccess => '購入が完了しました';

  @override
  String get purchaseFailed => '購入に失敗しました。もう一度お試しください。';
}
