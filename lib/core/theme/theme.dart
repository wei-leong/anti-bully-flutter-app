import "package:apu_assignment/core/theme/sizes.dart";
import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff605690),
      surfaceTint: Color(0xff605690),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe6deff),
      onPrimaryContainer: Color(0xff483f77),
      secondary: Color(0xff02677d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb3ebff),
      onSecondaryContainer: Color(0xff004e5f),
      tertiary: Color(0xff02677d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb3ebff),
      onTertiaryContainer: Color(0xff004e5f),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xff48454e),
      outline: Color(0xff79757f),
      outlineVariant: Color(0xffc9c4d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f36),
      inversePrimary: Color(0xffcabeff),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff1c1149),
      primaryFixedDim: Color(0xffcabeff),
      onPrimaryFixedVariant: Color(0xff483f77),
      secondaryFixed: Color(0xffb3ebff),
      onSecondaryFixed: Color(0xff001f27),
      secondaryFixedDim: Color(0xff86d1ea),
      onSecondaryFixedVariant: Color(0xff004e5f),
      tertiaryFixed: Color(0xffb3ebff),
      onTertiaryFixed: Color(0xff001f27),
      tertiaryFixedDim: Color(0xff86d1ea),
      onTertiaryFixedVariant: Color(0xff004e5f),
      surfaceDim: Color(0xffddd8e0),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xfff1ecf4),
      surfaceContainerHigh: Color(0xffebe6ee),
      surfaceContainerHighest: Color(0xffe6e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff382e65),
      surfaceTint: Color(0xff605690),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff6f65a0),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003c4a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff22768d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003c4a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff22768d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff121016),
      onSurfaceVariant: Color(0xff37353e),
      outline: Color(0xff54515a),
      outlineVariant: Color(0xff6f6b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f36),
      inversePrimary: Color(0xffcabeff),
      primaryFixed: Color(0xff6f65a0),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff574d86),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff22768d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff005d71),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff22768d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005d71),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c5cd),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xffebe6ee),
      surfaceContainerHigh: Color(0xffe0dbe3),
      surfaceContainerHighest: Color(0xffd4d0d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff2d235a),
      surfaceTint: Color(0xff605690),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4b4179),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00313d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005062),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00313d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff005062),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2b33),
      outlineVariant: Color(0xff4a4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff312f36),
      inversePrimary: Color(0xffcabeff),
      primaryFixed: Color(0xff4b4179),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff342a61),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005062),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003845),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff005062),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003845),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb7bf),
      surfaceBright: Color(0xfffdf8ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4eff7),
      surfaceContainer: Color(0xffe6e1e9),
      surfaceContainerHigh: Color(0xffd7d3db),
      surfaceContainerHighest: Color(0xffc9c5cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcabeff),
      surfaceTint: Color(0xffcabeff),
      onPrimary: Color(0xff32285f),
      primaryContainer: Color(0xff483f77),
      onPrimaryContainer: Color(0xffe6deff),
      secondary: Color(0xff86d1ea),
      onSecondary: Color(0xff003642),
      secondaryContainer: Color(0xff004e5f),
      onSecondaryContainer: Color(0xffb3ebff),
      tertiary: Color(0xff86d1ea),
      onTertiary: Color(0xff003642),
      tertiaryContainer: Color(0xff004e5f),
      onTertiaryContainer: Color(0xffb3ebff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141318),
      onSurface: Color(0xffe6e1e9),
      onSurfaceVariant: Color(0xffc9c4d0),
      outline: Color(0xff938f99),
      outlineVariant: Color(0xff48454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff605690),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff1c1149),
      primaryFixedDim: Color(0xffcabeff),
      onPrimaryFixedVariant: Color(0xff483f77),
      secondaryFixed: Color(0xffb3ebff),
      onSecondaryFixed: Color(0xff001f27),
      secondaryFixedDim: Color(0xff86d1ea),
      onSecondaryFixedVariant: Color(0xff004e5f),
      tertiaryFixed: Color(0xffb3ebff),
      onTertiaryFixed: Color(0xff001f27),
      tertiaryFixedDim: Color(0xff86d1ea),
      onTertiaryFixedVariant: Color(0xff004e5f),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff3a383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff201f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe0d7ff),
      surfaceTint: Color(0xffcabeff),
      onPrimary: Color(0xff271c53),
      primaryContainer: Color(0xff9389c6),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffa0e7ff),
      onSecondary: Color(0xff002a34),
      secondaryContainer: Color(0xff4e9bb2),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa0e7ff),
      onTertiary: Color(0xff002a34),
      tertiaryContainer: Color(0xff4e9bb2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdfdae6),
      outline: Color(0xffb4b0bb),
      outlineVariant: Color(0xff928f99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4a4078),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff12043e),
      primaryFixedDim: Color(0xffcabeff),
      onPrimaryFixedVariant: Color(0xff382e65),
      secondaryFixed: Color(0xffb3ebff),
      onSecondaryFixed: Color(0xff00141a),
      secondaryFixedDim: Color(0xff86d1ea),
      onSecondaryFixedVariant: Color(0xff003c4a),
      tertiaryFixed: Color(0xffb3ebff),
      onTertiaryFixed: Color(0xff00141a),
      tertiaryFixedDim: Color(0xff86d1ea),
      onTertiaryFixedVariant: Color(0xff003c4a),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff46434a),
      surfaceContainerLowest: Color(0xff08070c),
      surfaceContainerLow: Color(0xff1e1d22),
      surfaceContainer: Color(0xff29272d),
      surfaceContainerHigh: Color(0xff333238),
      surfaceContainerHighest: Color(0xff3f3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff3edff),
      surfaceTint: Color(0xffcabeff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc6bafb),
      onPrimaryContainer: Color(0xff0c0036),
      secondary: Color(0xffd9f4ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff82cde6),
      onSecondaryContainer: Color(0xff000d12),
      tertiary: Color(0xffd9f4ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff82cde6),
      onTertiaryContainer: Color(0xff000d12),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff3eef9),
      outlineVariant: Color(0xffc5c1cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4a4078),
      primaryFixed: Color(0xffe6deff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcabeff),
      onPrimaryFixedVariant: Color(0xff12043e),
      secondaryFixed: Color(0xffb3ebff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff86d1ea),
      onSecondaryFixedVariant: Color(0xff00141a),
      tertiaryFixed: Color(0xffb3ebff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff86d1ea),
      onTertiaryFixedVariant: Color(0xff00141a),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff514f56),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f24),
      surfaceContainer: Color(0xff312f36),
      surfaceContainerHigh: Color(0xff3c3a41),
      surfaceContainerHighest: Color(0xff48464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
    // inputDecorationTheme: InputDecorationTheme(
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8), // Matches your button radius
    //     borderSide: BorderSide(color: colorScheme.outline),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     borderSide: BorderSide(color: colorScheme.outline),
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(12),
    //     borderSide: BorderSide(color: colorScheme.primary, width: 2),
    //   ),
    // ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
      ),
    ),
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
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
