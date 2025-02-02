// import 'package:flutter/material.dart';

// const lightAppColor = ColorScheme(
//   brightness: Brightness.light,
//   primary: Color(0xFF1F4E75), // Biru Gelap
//   onPrimary: Color(0xFFFFFFFF),
//   primaryContainer: Color(0xFFD9E2FF),
//   onPrimaryContainer: Color(0xFF001A43),
//   secondary: Color(0xFFD9644A), // Oranye Tua
//   onSecondary: Color(0xFFFFFFFF),
//   secondaryContainer: Color(0xFFFFDBD0),
//   onSecondaryContainer: Color(0xFF390C00),
//   tertiary: Color(0xFFF8B45E), // Oranye Kekuningan
//   onTertiary: Color(0xFF1B1B1F),
//   tertiaryContainer: Color(0xFFFFE6D6),
//   onTertiaryContainer: Color(0xFF5A2000),
//   surface: Color(0xFFFFFFFF),
//   onSurface: Color(0xFF1B1B1F),
//   surfaceContainerHighest: Color(0xFFB2A099), // Abu Netral
//   onSurfaceVariant: Color(0xFF44474F),
//   error: Color(0xFFBA1A1A),
//   errorContainer: Color(0xFFFFDAD6),
//   onError: Color(0xFFFFFFFF),
//   onErrorContainer: Color(0xFF410002),
//   outline: Color(0xFF757780),
//   shadow: Color(0xFF000000),
//   inverseSurface: Color(0xFF303034),
//   onInverseSurface: Color(0xFFF2F0F4),
//   inversePrimary: Color(0xFFAFC6FF),
// );

// const darkAppColor = ColorScheme(
//   brightness: Brightness.dark,
//   primary: Color(0xFFAFC6FF), // Biru Lebih Cerah
//   onPrimary: Color(0xFF001A43),
//   primaryContainer: Color(0xFF1F4E75),
//   onPrimaryContainer: Color(0xFFD9E2FF),
//   secondary: Color(0xFFFFB4A2), // Oranye Muda
//   onSecondary: Color(0xFF5A2000),
//   secondaryContainer: Color(0xFFD9644A),
//   onSecondaryContainer: Color(0xFFFFDBD0),
//   tertiary: Color(0xFFFFE6D6), // Oranye Kekuningan Muda
//   onTertiary: Color(0xFF5A2000),
//   tertiaryContainer: Color(0xFFF8B45E),
//   onTertiaryContainer: Color(0xFF1B1B1F),
//   surface: Color(0xFF1B1B1F),
//   onSurface: Color(0xFFE4E1E4),
//   surfaceContainerHighest: Color(0xFF44474F),
//   onSurfaceVariant: Color(0xFFC5C6D0),
//   error: Color(0xFFFFB4A9),
//   errorContainer: Color(0xFF93000A),
//   onError: Color(0xFF690005),
//   onErrorContainer: Color(0xFFFFDAD6),
//   outline: Color(0xFF8E8E92),
//   shadow: Color(0xFF000000),
//   inverseSurface: Color(0xFFE4E1E4),
//   onInverseSurface: Color(0xFF1B1B1F),
//   inversePrimary: Color(0xFF1F4E75),
// );

import 'package:flutter/material.dart';

enum RestaurantColors {
  primary("Primary", Color(0xFF1B1B1F));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
