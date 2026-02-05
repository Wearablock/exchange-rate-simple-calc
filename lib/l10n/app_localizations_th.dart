// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'หน้าหลัก';

  @override
  String get history => 'ประวัติ';

  @override
  String get settings => 'ตั้งค่า';

  @override
  String get baseCurrency => 'สกุลเงินหลัก';

  @override
  String get targetCurrencies => 'สกุลเงินเป้าหมาย';

  @override
  String get lastUpdated => 'อัปเดตล่าสุด';

  @override
  String minutesAgo(int minutes) {
    return '$minutes นาทีที่แล้ว';
  }

  @override
  String get justNow => 'เมื่อสักครู่';

  @override
  String hoursAgo(int hours) {
    return '$hours ชั่วโมงที่แล้ว';
  }

  @override
  String get saveRate => 'บันทึกอัตรา';

  @override
  String get savedRates => 'อัตราที่บันทึก';

  @override
  String get noSavedRates => 'ไม่มีอัตราที่บันทึก';

  @override
  String get watchAd => 'ดูโฆษณาเพื่อบันทึก';

  @override
  String get rateSaved => 'บันทึกอัตราแล้ว';

  @override
  String get selectBaseCurrency => 'เลือกสกุลเงินหลัก';

  @override
  String get selectTargetCurrencies => 'เลือกสกุลเงินเป้าหมาย';

  @override
  String get getStarted => 'เริ่มต้น';

  @override
  String get next => 'ถัดไป';

  @override
  String get skip => 'ข้าม';

  @override
  String get refresh => 'รีเฟรช';

  @override
  String get addCurrency => 'เพิ่มสกุลเงิน';

  @override
  String get removeCurrency => 'ลบ';

  @override
  String get memo => 'บันทึก (ไม่บังคับ)';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get save => 'บันทึก';

  @override
  String get delete => 'ลบ';

  @override
  String get confirm => 'ยืนยัน';

  @override
  String get language => 'ภาษา';

  @override
  String get theme => 'ธีม';

  @override
  String get themeSystem => 'ระบบ';

  @override
  String get themeLight => 'สว่าง';

  @override
  String get themeDark => 'มืด';

  @override
  String get removeAds => 'ลบโฆษณา';

  @override
  String get removeAdsDescription => 'เพลิดเพลินกับการเรียนรู้แบบไม่มีโฆษณา';

  @override
  String get restorePurchase => 'กู้คืนการซื้อ';

  @override
  String get premium => 'พรีเมียม';

  @override
  String get version => 'เวอร์ชัน';

  @override
  String get privacyPolicy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get termsOfService => 'เงื่อนไขการใช้บริการ';

  @override
  String get support => 'ช่วยเหลือ';

  @override
  String get error => 'ข้อผิดพลาด';

  @override
  String get retry => 'ลองอีกครั้ง';

  @override
  String get noInternet => 'ไม่มีการเชื่อมต่ออินเทอร์เน็ต';

  @override
  String get loadingFailed => 'โหลดไม่สำเร็จ';

  @override
  String get currencySettings => 'ตั้งค่าสกุลเงิน';

  @override
  String get appSettings => 'ตั้งค่าแอป';

  @override
  String get about => 'เกี่ยวกับ';

  @override
  String get manageCurrencies => 'จัดการสกุลเงิน';

  @override
  String get searchCurrency => 'ค้นหาสกุลเงิน';

  @override
  String get popular => 'ยอดนิยม';

  @override
  String get all => 'ทั้งหมด';

  @override
  String get deleteConfirm => 'คุณแน่ใจหรือไม่ว่าต้องการลบ?';

  @override
  String get adRequired => 'ต้องดูโฆษณา';

  @override
  String get adNotReady => 'โฆษณายังไม่พร้อม';

  @override
  String get saveWithoutAd => 'บันทึกโดยไม่ดูโฆษณา?';

  @override
  String get networkError => 'กรุณาตรวจสอบการเชื่อมต่อเครือข่าย';
}
