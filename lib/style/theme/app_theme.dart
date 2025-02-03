import 'package:flutter/material.dart';
import 'package:restaurant_app/style/typography/app_text_styles.dart';

class AppThemes {
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLargeBold,
      bodyMedium: AppTextStyles.bodyLargeMedium,
      bodySmall: AppTextStyles.bodyLargeRegular,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff01677d),
      surfaceTint: Color(0xff01677d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb3ebff),
      onPrimaryContainer: Color(0xff004e5f),
      secondary: Color(0xff4b626a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee6f0),
      onSecondaryContainer: Color(0xff344a52),
      tertiary: Color(0xff595c7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdfe0ff),
      onTertiaryContainer: Color(0xff414465),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fafd),
      onSurface: Color(0xff171c1e),
      onSurfaceVariant: Color(0xff40484b),
      outline: Color(0xff70787c),
      outlineVariant: Color(0xffbfc8cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff86d1ea),
      primaryFixed: Color(0xffb3ebff),
      onPrimaryFixed: Color(0xff001f27),
      primaryFixedDim: Color(0xff86d1ea),
      onPrimaryFixedVariant: Color(0xff004e5f),
      secondaryFixed: Color(0xffcee6f0),
      onSecondaryFixed: Color(0xff061e25),
      secondaryFixedDim: Color(0xffb3cad4),
      onSecondaryFixedVariant: Color(0xff344a52),
      tertiaryFixed: Color(0xffdfe0ff),
      onTertiaryFixed: Color(0xff151937),
      tertiaryFixedDim: Color(0xffc1c4eb),
      onTertiaryFixedVariant: Color(0xff414465),
      surfaceDim: Color(0xffd6dbdd),
      surfaceBright: Color(0xfff5fafd),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffeaeff1),
      surfaceContainerHigh: Color(0xffe4e9ec),
      surfaceContainerHighest: Color(0xffdee3e6),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff86d1ea),
      surfaceTint: Color(0xff86d1ea),
      onPrimary: Color(0xff003642),
      primaryContainer: Color(0xff004e5f),
      onPrimaryContainer: Color(0xffb3ebff),
      secondary: Color(0xffb3cad4),
      onSecondary: Color(0xff1d333b),
      secondaryContainer: Color(0xff344a52),
      onSecondaryContainer: Color(0xffcee6f0),
      tertiary: Color(0xffc1c4eb),
      onTertiary: Color(0xff2a2e4d),
      tertiaryContainer: Color(0xff414465),
      onTertiaryContainer: Color(0xffdfe0ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e6),
      onSurfaceVariant: Color(0xffbfc8cc),
      outline: Color(0xff899296),
      outlineVariant: Color(0xff40484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e6),
      inversePrimary: Color(0xff01677d),
      primaryFixed: Color(0xffb3ebff),
      onPrimaryFixed: Color(0xff001f27),
      primaryFixedDim: Color(0xff86d1ea),
      onPrimaryFixedVariant: Color(0xff004e5f),
      secondaryFixed: Color(0xffcee6f0),
      onSecondaryFixed: Color(0xff061e25),
      secondaryFixedDim: Color(0xffb3cad4),
      onSecondaryFixedVariant: Color(0xff344a52),
      tertiaryFixed: Color(0xffdfe0ff),
      onTertiaryFixed: Color(0xff151937),
      tertiaryFixedDim: Color(0xffc1c4eb),
      onTertiaryFixedVariant: Color(0xff414465),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff0a0f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: _textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily dark;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.dark,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
