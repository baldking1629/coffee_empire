import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static const double cardRadius = 20;
  static const double buttonRadius = 16;

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.cardHighlight, AppColors.card],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
  );

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: AppColors.shadow, blurRadius: 12, offset: Offset(0, 4)),
  ];

  static BoxDecoration cardDecoration({
    Color borderColor = AppColors.cardBorder,
  }) => BoxDecoration(
    gradient: cardGradient,
    borderRadius: BorderRadius.circular(cardRadius),
    border: Border.all(color: borderColor),
    boxShadow: cardShadow,
  );

  static ThemeData build() {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.copper,
      secondary: AppColors.gold,
      tertiary: AppColors.mint,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.cardBorder,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundBottom,
      dividerTheme: const DividerThemeData(color: AppColors.cardBorder),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: AppColors.cardBorder),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.card,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.copper
                : AppColors.textSecondary,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontSize: 12,
            color: states.contains(WidgetState.selected)
                ? AppColors.textPrimary
                : AppColors.textSecondary,
          ),
        ),
      ),
      textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
    );
  }
}
