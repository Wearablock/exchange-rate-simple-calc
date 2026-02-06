// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'الرئيسية';

  @override
  String get history => 'السجل';

  @override
  String get settings => 'الإعدادات';

  @override
  String get baseCurrency => 'العملة الأساسية';

  @override
  String get targetCurrencies => 'العملات المستهدفة';

  @override
  String get lastUpdated => 'آخر تحديث';

  @override
  String minutesAgo(int minutes) {
    return 'منذ $minutes دقيقة';
  }

  @override
  String get justNow => 'الآن';

  @override
  String hoursAgo(int hours) {
    return 'منذ $hours ساعة';
  }

  @override
  String get saveRate => 'حفظ السعر';

  @override
  String get savedRates => 'الأسعار المحفوظة';

  @override
  String get noSavedRates => 'لا توجد أسعار محفوظة';

  @override
  String get watchAd => 'شاهد إعلان للحفظ';

  @override
  String get rateSaved => 'تم حفظ السعر';

  @override
  String get selectBaseCurrency => 'اختر العملة الأساسية';

  @override
  String get selectTargetCurrencies => 'اختر العملات المستهدفة';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get next => 'التالي';

  @override
  String get skip => 'تخطي';

  @override
  String get refresh => 'تحديث';

  @override
  String get addCurrency => 'إضافة عملة';

  @override
  String get removeCurrency => 'إزالة';

  @override
  String get memo => 'ملاحظة (اختياري)';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get confirm => 'تأكيد';

  @override
  String get refreshConfirm => 'هل تريد تحديث أسعار الصرف؟';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get removeAds => 'إزالة الإعلانات';

  @override
  String get removeAdsDescription => 'استمتع بالتعلم بدون إعلانات للأبد';

  @override
  String get restorePurchase => 'استعادة الشراء';

  @override
  String get premium => 'بريميوم';

  @override
  String get version => 'الإصدار';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get support => 'الدعم';

  @override
  String get error => 'خطأ';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get loadingFailed => 'فشل التحميل';

  @override
  String get currencySettings => 'إعدادات العملة';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get about => 'حول';

  @override
  String get manageCurrencies => 'إدارة العملات';

  @override
  String get searchCurrency => 'البحث عن عملة';

  @override
  String get popular => 'الشائعة';

  @override
  String get all => 'الكل';

  @override
  String get deleteConfirm => 'هل أنت متأكد من الحذف؟';

  @override
  String get adRequired => 'مطلوب مشاهدة إعلان';

  @override
  String get adNotReady => 'الإعلان غير جاهز بعد';

  @override
  String get saveWithoutAd => 'حفظ بدون إعلان؟';

  @override
  String get networkError => 'يرجى التحقق من اتصال الشبكة';

  @override
  String get saveRateDescription => 'حفظ سعر الصرف الحالي للرجوع إليه لاحقاً';

  @override
  String get viewChart => 'عرض الرسم البياني';

  @override
  String chartDescription(int count) {
    return 'عرض اتجاه سعر الصرف مع $count سجل';
  }
}
