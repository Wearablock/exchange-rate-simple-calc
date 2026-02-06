// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Easy Exchange';

  @override
  String get home => 'Beranda';

  @override
  String get history => 'Riwayat';

  @override
  String get settings => 'Pengaturan';

  @override
  String get baseCurrency => 'Mata uang dasar';

  @override
  String get targetCurrencies => 'Mata uang target';

  @override
  String get lastUpdated => 'Terakhir diperbarui';

  @override
  String minutesAgo(int minutes) {
    return '$minutes menit lalu';
  }

  @override
  String get justNow => 'Baru saja';

  @override
  String hoursAgo(int hours) {
    return '$hours jam lalu';
  }

  @override
  String get saveRate => 'Simpan kurs';

  @override
  String get savedRates => 'Kurs tersimpan';

  @override
  String get noSavedRates => 'Belum ada kurs tersimpan';

  @override
  String get watchAd => 'Tonton iklan untuk menyimpan';

  @override
  String get rateSaved => 'Kurs tersimpan';

  @override
  String get selectBaseCurrency => 'Pilih mata uang dasar';

  @override
  String get selectTargetCurrencies => 'Pilih mata uang target';

  @override
  String get getStarted => 'Mulai';

  @override
  String get next => 'Berikutnya';

  @override
  String get skip => 'Lewati';

  @override
  String get refresh => 'Segarkan';

  @override
  String get addCurrency => 'Tambah mata uang';

  @override
  String get removeCurrency => 'Hapus';

  @override
  String get memo => 'Catatan (opsional)';

  @override
  String get cancel => 'Batal';

  @override
  String get save => 'Simpan';

  @override
  String get delete => 'Hapus';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get refreshConfirm => 'Apakah Anda ingin memperbarui kurs?';

  @override
  String get language => 'Bahasa';

  @override
  String get theme => 'Tema';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get removeAds => 'Hapus iklan';

  @override
  String get removeAdsDescription => 'Nikmati belajar tanpa iklan selamanya';

  @override
  String get restorePurchase => 'Pulihkan pembelian';

  @override
  String get premium => 'Premium';

  @override
  String get version => 'Versi';

  @override
  String get privacyPolicy => 'Kebijakan privasi';

  @override
  String get termsOfService => 'Ketentuan layanan';

  @override
  String get support => 'Dukungan';

  @override
  String get error => 'Kesalahan';

  @override
  String get retry => 'Coba lagi';

  @override
  String get noInternet => 'Tidak ada koneksi Internet';

  @override
  String get loadingFailed => 'Gagal memuat';

  @override
  String get currencySettings => 'Pengaturan mata uang';

  @override
  String get appSettings => 'Pengaturan aplikasi';

  @override
  String get about => 'Tentang';

  @override
  String get manageCurrencies => 'Kelola mata uang';

  @override
  String get searchCurrency => 'Cari mata uang';

  @override
  String get popular => 'Populer';

  @override
  String get all => 'Semua';

  @override
  String get deleteConfirm => 'Yakin ingin menghapus?';

  @override
  String get adRequired => 'Perlu menonton iklan';

  @override
  String get adNotReady => 'Iklan belum siap';

  @override
  String get saveWithoutAd => 'Simpan tanpa menonton iklan?';

  @override
  String get networkError => 'Periksa koneksi jaringan Anda';

  @override
  String get saveRateDescription =>
      'Simpan kurs saat ini untuk referensi nanti';

  @override
  String get viewChart => 'Lihat grafik';

  @override
  String chartDescription(int count) {
    return 'Lihat tren kurs dengan $count catatan';
  }

  @override
  String get selectLanguage => 'Pilih Bahasa';

  @override
  String get systemDefault => 'Default Sistem';
}
