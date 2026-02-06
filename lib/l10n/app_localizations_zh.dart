// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => '首页';

  @override
  String get history => '历史';

  @override
  String get settings => '设置';

  @override
  String get baseCurrency => '基准货币';

  @override
  String get targetCurrencies => '目标货币';

  @override
  String get lastUpdated => '最后更新';

  @override
  String minutesAgo(int minutes) {
    return '$minutes分钟前';
  }

  @override
  String get justNow => '刚刚';

  @override
  String hoursAgo(int hours) {
    return '$hours小时前';
  }

  @override
  String get saveRate => '保存汇率';

  @override
  String get savedRates => '已保存的汇率';

  @override
  String get noSavedRates => '暂无保存的汇率';

  @override
  String get watchAd => '观看广告后保存';

  @override
  String get rateSaved => '汇率已保存';

  @override
  String get selectBaseCurrency => '请选择基准货币';

  @override
  String get selectTargetCurrencies => '请选择目标货币';

  @override
  String get getStarted => '开始';

  @override
  String get next => '下一步';

  @override
  String get skip => '跳过';

  @override
  String get refresh => '刷新';

  @override
  String get addCurrency => '添加货币';

  @override
  String get removeCurrency => '删除';

  @override
  String get memo => '备注（可选）';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get confirm => '确认';

  @override
  String get refreshConfirm => '是否刷新汇率信息？';

  @override
  String get language => '语言';

  @override
  String get theme => '主题';

  @override
  String get themeSystem => '系统';

  @override
  String get themeLight => '浅色';

  @override
  String get themeDark => '深色';

  @override
  String get removeAds => '移除广告';

  @override
  String get removeAdsDescription => '永久移除所有广告';

  @override
  String get restorePurchase => '恢复购买';

  @override
  String get premium => '高级版';

  @override
  String get version => '版本';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get support => '支持';

  @override
  String get error => '错误';

  @override
  String get retry => '重试';

  @override
  String get noInternet => '无网络连接';

  @override
  String get loadingFailed => '加载数据失败';

  @override
  String get currencySettings => '货币设置';

  @override
  String get appSettings => '应用设置';

  @override
  String get about => '关于';

  @override
  String get manageCurrencies => '管理货币';

  @override
  String get searchCurrency => '搜索货币';

  @override
  String get popular => '热门';

  @override
  String get all => '全部';

  @override
  String get deleteConfirm => '确定要删除吗？';

  @override
  String get adRequired => '需要观看广告';

  @override
  String get adNotReady => '广告尚未准备好';

  @override
  String get saveWithoutAd => '不看广告直接保存？';

  @override
  String get networkError => '请检查网络连接';

  @override
  String get saveRateDescription => '保存当前汇率以供日后参考';

  @override
  String get viewChart => '查看图表';

  @override
  String chartDescription(int count) {
    return '查看$count条记录的汇率趋势';
  }

  @override
  String get selectLanguage => '选择语言';

  @override
  String get systemDefault => '系统默认';

  @override
  String get welcomeDescription => '查看实时汇率\n记录重要的汇率信息';

  @override
  String get baseCurrencyDescription => '选择汇率比较的基准货币';

  @override
  String get targetCurrencyDescription => '选择您感兴趣的货币';

  @override
  String selectedCount(int count) {
    return '已选择$count个';
  }

  @override
  String get emptyStateHint => '在主页保存汇率';

  @override
  String get adFreeActivated => '所有广告已移除';

  @override
  String get adFreePurchaseDescription => '一次性购买移除所有广告';

  @override
  String get noCurrencies => '没有可显示的货币';

  @override
  String get purchaseSuccess => '购买成功';

  @override
  String get purchaseFailed => '购买失败，请重试。';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => '首頁';

  @override
  String get history => '歷史';

  @override
  String get settings => '設定';

  @override
  String get baseCurrency => '基準貨幣';

  @override
  String get targetCurrencies => '目標貨幣';

  @override
  String get lastUpdated => '最後更新';

  @override
  String minutesAgo(int minutes) {
    return '$minutes分鐘前';
  }

  @override
  String get justNow => '剛剛';

  @override
  String hoursAgo(int hours) {
    return '$hours小時前';
  }

  @override
  String get saveRate => '儲存匯率';

  @override
  String get savedRates => '已儲存的匯率';

  @override
  String get noSavedRates => '暫無儲存的匯率';

  @override
  String get watchAd => '觀看廣告後儲存';

  @override
  String get rateSaved => '匯率已儲存';

  @override
  String get selectBaseCurrency => '請選擇基準貨幣';

  @override
  String get selectTargetCurrencies => '請選擇目標貨幣';

  @override
  String get getStarted => '開始';

  @override
  String get next => '下一步';

  @override
  String get skip => '跳過';

  @override
  String get refresh => '重新整理';

  @override
  String get addCurrency => '新增貨幣';

  @override
  String get removeCurrency => '刪除';

  @override
  String get memo => '備註（選填）';

  @override
  String get cancel => '取消';

  @override
  String get save => '儲存';

  @override
  String get delete => '刪除';

  @override
  String get confirm => '確認';

  @override
  String get refreshConfirm => '是否刷新匯率資訊？';

  @override
  String get language => '語言';

  @override
  String get theme => '主題';

  @override
  String get themeSystem => '系統';

  @override
  String get themeLight => '淺色';

  @override
  String get themeDark => '深色';

  @override
  String get removeAds => '移除廣告';

  @override
  String get removeAdsDescription => '永久移除所有廣告';

  @override
  String get restorePurchase => '恢復購買';

  @override
  String get premium => '進階版';

  @override
  String get version => '版本';

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get termsOfService => '服務條款';

  @override
  String get support => '支援';

  @override
  String get error => '錯誤';

  @override
  String get retry => '重試';

  @override
  String get noInternet => '無網路連線';

  @override
  String get loadingFailed => '載入資料失敗';

  @override
  String get currencySettings => '貨幣設定';

  @override
  String get appSettings => '應用程式設定';

  @override
  String get about => '關於';

  @override
  String get manageCurrencies => '管理貨幣';

  @override
  String get searchCurrency => '搜尋貨幣';

  @override
  String get popular => '熱門';

  @override
  String get all => '全部';

  @override
  String get deleteConfirm => '確定要刪除嗎？';

  @override
  String get adRequired => '需要觀看廣告';

  @override
  String get adNotReady => '廣告尚未準備好';

  @override
  String get saveWithoutAd => '不看廣告直接儲存？';

  @override
  String get networkError => '請檢查網路連線';

  @override
  String get saveRateDescription => '儲存目前匯率以供日後參考';

  @override
  String get viewChart => '查看圖表';

  @override
  String chartDescription(int count) {
    return '查看$count筆記錄的匯率趨勢';
  }

  @override
  String get selectLanguage => '選擇語言';

  @override
  String get systemDefault => '系統預設';

  @override
  String get welcomeDescription => '查看即時匯率\n記錄重要的匯率資訊';

  @override
  String get baseCurrencyDescription => '選擇匯率比較的基準貨幣';

  @override
  String get targetCurrencyDescription => '選擇您感興趣的貨幣';

  @override
  String selectedCount(int count) {
    return '已選擇$count個';
  }

  @override
  String get emptyStateHint => '在主頁儲存匯率';

  @override
  String get adFreeActivated => '所有廣告已移除';

  @override
  String get adFreePurchaseDescription => '一次性購買移除所有廣告';

  @override
  String get noCurrencies => '沒有可顯示的貨幣';

  @override
  String get purchaseSuccess => '購買成功';

  @override
  String get purchaseFailed => '購買失敗，請重試。';
}
