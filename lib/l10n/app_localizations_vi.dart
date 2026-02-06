// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Trang chủ';

  @override
  String get history => 'Lịch sử';

  @override
  String get settings => 'Cài đặt';

  @override
  String get baseCurrency => 'Tiền tệ cơ sở';

  @override
  String get targetCurrencies => 'Tiền tệ mục tiêu';

  @override
  String get lastUpdated => 'Cập nhật lần cuối';

  @override
  String minutesAgo(int minutes) {
    return '$minutes phút trước';
  }

  @override
  String get justNow => 'Vừa xong';

  @override
  String hoursAgo(int hours) {
    return '$hours giờ trước';
  }

  @override
  String get saveRate => 'Lưu tỷ giá';

  @override
  String get savedRates => 'Tỷ giá đã lưu';

  @override
  String get noSavedRates => 'Chưa có tỷ giá nào được lưu';

  @override
  String get watchAd => 'Xem quảng cáo để lưu';

  @override
  String get rateSaved => 'Đã lưu tỷ giá';

  @override
  String get selectBaseCurrency => 'Chọn tiền tệ cơ sở';

  @override
  String get selectTargetCurrencies => 'Chọn tiền tệ mục tiêu';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get next => 'Tiếp theo';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get refresh => 'Làm mới';

  @override
  String get addCurrency => 'Thêm tiền tệ';

  @override
  String get removeCurrency => 'Xóa';

  @override
  String get memo => 'Ghi chú (tùy chọn)';

  @override
  String get cancel => 'Hủy';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get confirm => 'Xác nhận';

  @override
  String get refreshConfirm => 'Bạn có muốn làm mới tỷ giá hối đoái không?';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get theme => 'Giao diện';

  @override
  String get themeSystem => 'Hệ thống';

  @override
  String get themeLight => 'Sáng';

  @override
  String get themeDark => 'Tối';

  @override
  String get removeAds => 'Xóa quảng cáo';

  @override
  String get removeAdsDescription => 'Tận hưởng học tập không quảng cáo';

  @override
  String get restorePurchase => 'Khôi phục mua hàng';

  @override
  String get premium => 'Cao cấp';

  @override
  String get version => 'Phiên bản';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get termsOfService => 'Điều khoản dịch vụ';

  @override
  String get support => 'Hỗ trợ';

  @override
  String get error => 'Lỗi';

  @override
  String get retry => 'Thử lại';

  @override
  String get noInternet => 'Không có kết nối Internet';

  @override
  String get loadingFailed => 'Tải thất bại';

  @override
  String get currencySettings => 'Cài đặt tiền tệ';

  @override
  String get appSettings => 'Cài đặt ứng dụng';

  @override
  String get about => 'Giới thiệu';

  @override
  String get manageCurrencies => 'Quản lý tiền tệ';

  @override
  String get searchCurrency => 'Tìm kiếm tiền tệ';

  @override
  String get popular => 'Phổ biến';

  @override
  String get all => 'Tất cả';

  @override
  String get deleteConfirm => 'Bạn có chắc chắn muốn xóa?';

  @override
  String get adRequired => 'Cần xem quảng cáo';

  @override
  String get adNotReady => 'Quảng cáo chưa sẵn sàng';

  @override
  String get saveWithoutAd => 'Lưu mà không xem quảng cáo?';

  @override
  String get networkError => 'Vui lòng kiểm tra kết nối mạng';
}
