import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_config.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // 폰트 두께 체계 (3단계)
  //  - bold:     강조 (Display, Headline, AppBar 타이틀)
  //  - semiBold: 준강조 (Title, Label, 버튼, 네비 선택)
  //  - medium:   기본 (Body, Caption, 네비 미선택)
  // ============================================================
  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      // Bold — 대형 타이틀, 페이지 헤드라인
      displayLarge: base.displayLarge?.copyWith(fontWeight: _bold),
      displayMedium: base.displayMedium?.copyWith(fontWeight: _bold),
      displaySmall: base.displaySmall?.copyWith(fontWeight: _bold),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: _bold),
      headlineMedium: base.headlineMedium?.copyWith(fontWeight: _bold),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: _bold),
      // Semi-bold — 섹션 타이틀, 라벨, 액션
      titleLarge: base.titleLarge?.copyWith(fontWeight: _semiBold),
      titleMedium: base.titleMedium?.copyWith(fontWeight: _semiBold),
      titleSmall: base.titleSmall?.copyWith(fontWeight: _semiBold),
      labelLarge: base.labelLarge?.copyWith(fontWeight: _semiBold),
      labelMedium: base.labelMedium?.copyWith(fontWeight: _semiBold),
      labelSmall: base.labelSmall?.copyWith(fontWeight: _semiBold),
      // Medium — 본문 텍스트
      bodyLarge: base.bodyLarge?.copyWith(fontWeight: _medium),
      bodyMedium: base.bodyMedium?.copyWith(fontWeight: _medium),
      bodySmall: base.bodySmall?.copyWith(fontWeight: _medium),
    );
  }

  // ============================================================
  // Light Theme
  // ============================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppConfig.primaryColor,
        onPrimary: Colors.white,
        secondary: AppConfig.secondaryColor,
        onSecondary: Colors.white,
        surface: AppConfig.surfaceLightColor,
        onSurface: Colors.black87,
        error: AppConfig.negativeColor,
      ),
      scaffoldBackgroundColor: AppConfig.surfaceLightColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConfig.primaryColor),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: _bold,
          color: AppConfig.primaryColor,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(
            fontWeight: _semiBold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConfig.primaryColor,
          side: BorderSide(color: AppConfig.primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConfig.primaryColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppConfig.primaryColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      textTheme: _buildTextTheme(GoogleFonts.outfitTextTheme()),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 3,
        indicatorColor: AppConfig.primaryColor.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.outfit(
              color: AppConfig.primaryColor,
              fontWeight: _semiBold,
              fontSize: 12,
            );
          }
          return GoogleFonts.outfit(
            color: Colors.grey,
            fontWeight: _medium,
            fontSize: 12,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: AppConfig.primaryColor);
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade200,
        thickness: 1,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // ============================================================
  // Dark Theme
  // ============================================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppConfig.primaryLightColor,
        onPrimary: Colors.black,
        secondary: AppConfig.secondaryLightColor,
        onSecondary: Colors.black,
        surface: AppConfig.surfaceDarkColor,
        onSurface: Colors.white,
        error: AppConfig.negativeColor,
      ),
      scaffoldBackgroundColor: AppConfig.surfaceDarkColor,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppConfig.primaryLightColor),
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: _bold,
          color: AppConfig.primaryLightColor,
        ),
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E1E1E),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConfig.primaryLightColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.outfit(
            fontWeight: _semiBold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppConfig.primaryLightColor,
          side: BorderSide(color: AppConfig.primaryLightColor),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppConfig.primaryLightColor,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppConfig.primaryLightColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      textTheme: _buildTextTheme(GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme)),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 3,
        indicatorColor: AppConfig.primaryLightColor.withValues(alpha: 0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.outfit(
              color: AppConfig.primaryLightColor,
              fontWeight: _semiBold,
              fontSize: 12,
            );
          }
          return GoogleFonts.outfit(
            color: Colors.grey,
            fontWeight: _medium,
            fontSize: 12,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: AppConfig.primaryLightColor);
          }
          return const IconThemeData(color: Colors.grey);
        }),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2A2A2A),
        thickness: 1,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
