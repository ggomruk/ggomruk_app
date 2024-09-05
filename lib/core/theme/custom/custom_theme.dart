import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/app_colors.dart';
import 'custom_font_weight.dart';

class CustomTheme {
  static ThemeData getLightTheme() {
    return _getThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      backgroundColor: AppColors.background,
      surfaceColor: AppColors.surface,
      errorColor: AppColors.error,
    );
  }

  static ThemeData getDarkTheme() {
    return _getThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      backgroundColor: AppColors.darkBackground,
      surfaceColor: AppColors.darkSurface,
      errorColor: AppColors.error,
    );
  }

  static ThemeData _getThemeData({
    required Brightness brightness,
    required Color primaryColor,
    required Color backgroundColor,
    required Color surfaceColor,
    required Color errorColor,
  }) {
    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: primaryColor,
      onPrimary: brightness == Brightness.light ? AppColors.onPrimary : AppColors.darkBackground,
      secondary: brightness == Brightness.light ? AppColors.secondary : AppColors.darkSecondary,
      onSecondary: brightness == Brightness.light ? AppColors.onSecondary : AppColors.darkOnSurface,
      error: errorColor,
      onError: AppColors.onError,
      background: backgroundColor,
      onBackground: brightness == Brightness.light ? AppColors.onBackground : AppColors.darkOnBackground,
      surface: surfaceColor,
      onSurface: brightness == Brightness.light ? AppColors.onSurface : AppColors.darkOnSurface,
      surfaceVariant: brightness == Brightness.light ? AppColors.surfaceVariant : AppColors.darkSecondary,
      onSurfaceVariant: brightness == Brightness.light ? AppColors.onSurfaceVariant : AppColors.darkOnSurface,
      outline: brightness == Brightness.light ? AppColors.outline : AppColors.darkOnSurface.withOpacity(0.5),
      shadow: AppColors.shadow,
      inverseSurface: AppColors.inverseSurface,
      onInverseSurface: AppColors.onInverseSurface,
      inversePrimary: AppColors.inversePrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _getTextTheme(brightness),
      fontFamily: 'Pretendard',
    ).withCustomWidgetThemes();
  }



  static TextTheme _getTextTheme(Brightness brightness) {
    final Color textColor = brightness == Brightness.light
        ? AppColors.black
        : AppColors.darkOnSurface;
    final Color secondaryTextColor = brightness == Brightness.light
        ? AppColors.contentSecondary
        : AppColors.darkOnBackground;

    return TextTheme(
      displayLarge: TextStyle(
        color: textColor,
        fontSize: 57,
        fontWeight: CustomFontWeight.regular,
        height: 68 / 57,
      ),
      displayMedium: TextStyle(
        color: textColor,
        fontSize: 45,
        fontWeight: CustomFontWeight.regular,
        height: 54 / 45,
      ),
      displaySmall: TextStyle(
        color: textColor,
        fontSize: 36,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: -0.35,
        height: 45 / 36,
      ),
      headlineLarge: TextStyle(
        color: textColor,
        fontSize: 32,
        fontWeight: CustomFontWeight.semiBold,
        height: 40 / 32,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: CustomFontWeight.semiBold,
        height: 28 / 22,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: -0.35,
        height: 25 / 20,
      ),
      titleLarge: TextStyle(
        color: textColor,
        fontSize: 18,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: -0.35,
        height: 23 / 18,
      ),
      titleMedium: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.1,
        height: 20 / 16,
      ),
      titleSmall: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.12,
        height: 18 / 14,
      ),
      bodyLarge: TextStyle(
        color: textColor,
        fontSize: 16,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.5,
        height: 24 / 16,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.25,
        height: 21 / 14,
      ),
      bodySmall: TextStyle(
        color: textColor,
        fontSize: 12,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.4,
        height: 18 / 12,
      ),
      labelLarge: TextStyle(
        color: secondaryTextColor,
        fontSize: 13,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.5,
        height: 16 / 13,
      ),
      labelMedium: TextStyle(
        color: secondaryTextColor,
        fontSize: 12,
        fontWeight: CustomFontWeight.regular,
        letterSpacing: 0.25,
        height: 15 / 12,
      ),
      labelSmall: TextStyle(
        color: secondaryTextColor,
        fontSize: 11,
        fontWeight: CustomFontWeight.regular,
        height: 15 / 11,
      ),
    );
  }

  /// Typography
  static final TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      color: AppColors.black,
      fontSize: 57,
      fontWeight: CustomFontWeight.regular,
      height: 68 / 57,
    ),
    displayMedium: TextStyle(
      color: AppColors.black,
      fontSize: 45,
      fontWeight: CustomFontWeight.regular,
      height: 54 / 45,
    ),
    displaySmall: TextStyle(
      color: AppColors.black,
      fontSize: 36,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: -0.35,
      height: 45 / 36,
    ),
    headlineLarge: TextStyle(
      color: AppColors.black,
      fontSize: 32,
      fontWeight: CustomFontWeight.semiBold,
      height: 40 / 32,
    ),
    headlineMedium: TextStyle(
      color: AppColors.black,
      fontSize: 22,
      fontWeight: CustomFontWeight.semiBold,
      height: 28 / 22,
    ),
    headlineSmall: TextStyle(
      color: AppColors.black,
      fontSize: 20,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: -0.35,
      height: 25 / 20,
    ),
    titleLarge: TextStyle(
      color: AppColors.black,
      fontSize: 18,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: -0.35,
      height: 23 / 18,
    ),
    titleMedium: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.1,
      height: 20 / 16,
    ),
    titleSmall: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.12,
      height: 18 / 14,
    ),
    bodyLarge: TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.5,
      height: 24 / 16,
    ),
    bodyMedium: TextStyle(
      color: AppColors.black,
      fontSize: 14,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.25,
      height: 21 / 14,
    ),
    bodySmall: TextStyle(
      color: AppColors.black,
      fontSize: 12,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.4,
      height: 18 / 12,
    ),
    labelLarge: TextStyle(
      color: AppColors.black,
      fontSize: 13,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.5,
      height: 16 / 13,
    ),
    labelMedium: TextStyle(
      color: AppColors.black,
      fontSize: 12,
      fontWeight: CustomFontWeight.regular,
      letterSpacing: 0.25,
      height: 15 / 12,
    ),
    labelSmall: TextStyle(
      color: AppColors.black,
      fontSize: 11,
      fontWeight: CustomFontWeight.regular,
      height: 15 / 11,
    ),
  );

  static final TextStyle customAppBarStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 24,
    fontWeight: CustomFontWeight.bold,
    height: 48 / 39,
  );

  static final TextStyle customButtonTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: CustomFontWeight.bold,
    height: 18 / 11,
  );

  /// color_scheme
  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryContainer,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    error: AppColors.error,
    onError: AppColors.onError,
    background: AppColors.background,
    onBackground: AppColors.onBackground,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceVariant: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    shadow: AppColors.shadow,
    inverseSurface: AppColors.inverseSurface,
    onInverseSurface: AppColors.onInverseSurface,
    inversePrimary: AppColors.inversePrimary,
  );

  /// Get complete ThemeData
  static ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: 'Pretendard',
    );
  }
}

/// Extension to add custom colors to ColorScheme
extension ColorSchemeEx on ColorScheme {
  Color get positive => AppColors.positive;

  Color get contentPrimary => AppColors.contentPrimary;

  Color get contentSecondary => AppColors.contentSecondary;

  Color get contentTertiary => AppColors.contentTertiary;

  Color get contentFourth => AppColors.contentFourth;
}

/// Extension to add custom widget themes
extension CustomThemeEx on ThemeData {
  ThemeData withCustomWidgetThemes() {
    return copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        systemOverlayStyle: brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: colorScheme.surface,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.5),
        selectedIconTheme: IconThemeData(color: colorScheme.primary),
        unselectedIconTheme: IconThemeData(color: colorScheme.onSurface.withOpacity(0.5)),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 4,
        focusElevation: 4,
        hoverElevation: 4,
        splashColor: colorScheme.onPrimaryContainer.withOpacity(0.12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: colorScheme.onPrimary,
          backgroundColor: colorScheme.primary,
          disabledForegroundColor: colorScheme.onSurface.withOpacity(0.38),
          disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        labelStyle:
            textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          final Color color = states.contains(MaterialState.focused)
              ? colorScheme.primary
              : colorScheme.onSurfaceVariant;
          return TextStyle(color: color);
        }),
        hintStyle: textTheme.bodyLarge
            ?.copyWith(color: colorScheme.onSurfaceVariant.withOpacity(0.6)),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.primary.withOpacity(0.5);
          }
          return null;
        }),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colorScheme.primary,
        inactiveTrackColor: colorScheme.primary.withOpacity(0.3),
        thumbColor: colorScheme.primary,
        overlayColor: colorScheme.primary.withOpacity(0.12),
        valueIndicatorColor: colorScheme.primary,
        valueIndicatorTextStyle:
            textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
      cardTheme: CardTheme(
        color: colorScheme.surface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: colorScheme.onInverseSurface),
        actionTextColor: colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
