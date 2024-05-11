import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff755b0b),
      surfaceTint: Color(0xff755b0b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdf96),
      onPrimaryContainer: Color(0xff251a00),
      secondary: Color(0xff725c0c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffe087),
      onSecondaryContainer: Color(0xff241a00),
      tertiary: Color(0xff496548),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcaebc6),
      onTertiaryContainer: Color(0xff05210a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfffff8f1),
      onBackground: Color(0xff1f1b13),
      surface: Color(0xfffff8f1),
      onSurface: Color(0xff1f1b13),
      surfaceVariant: Color(0xffece1cf),
      onSurfaceVariant: Color(0xff4d4639),
      outline: Color(0xff7e7667),
      outlineVariant: Color(0xffd0c5b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff343027),
      inverseOnSurface: Color(0xfff9efe2),
      inversePrimary: Color(0xffe6c26c),
      primaryFixed: Color(0xffffdf96),
      onPrimaryFixed: Color(0xff251a00),
      primaryFixedDim: Color(0xffe6c26c),
      onPrimaryFixedVariant: Color(0xff5a4400),
      secondaryFixed: Color(0xffffe087),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff574500),
      tertiaryFixed: Color(0xffcaebc6),
      onTertiaryFixed: Color(0xff05210a),
      tertiaryFixedDim: Color(0xffafcfab),
      onTertiaryFixedVariant: Color(0xff314d32),
      surfaceDim: Color(0xffe2d9cc),
      surfaceBright: Color(0xfffff8f1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf2e5),
      surfaceContainer: Color(0xfff6eddf),
      surfaceContainerHigh: Color(0xfff0e7d9),
      surfaceContainerHighest: Color(0xffeae1d4),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff554000),
      surfaceTint: Color(0xff755b0b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8e7123),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff524100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8a7223),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2d492e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff5e7c5d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f1),
      onBackground: Color(0xff1f1b13),
      surface: Color(0xfffff8f1),
      onSurface: Color(0xff1f1b13),
      surfaceVariant: Color(0xffece1cf),
      onSurfaceVariant: Color(0xff494235),
      outline: Color(0xff665e50),
      outlineVariant: Color(0xff827a6b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff343027),
      inverseOnSurface: Color(0xfff9efe2),
      inversePrimary: Color(0xffe6c26c),
      primaryFixed: Color(0xff8e7123),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff735808),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8a7223),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff705909),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff5e7c5d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff466346),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe2d9cc),
      surfaceBright: Color(0xfffff8f1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf2e5),
      surfaceContainer: Color(0xfff6eddf),
      surfaceContainerHigh: Color(0xfff0e7d9),
      surfaceContainerHighest: Color(0xffeae1d4),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff2d2000),
      surfaceTint: Color(0xff755b0b),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff554000),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2b2100),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff524100),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff0c2810),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2d492e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfffff8f1),
      onBackground: Color(0xff1f1b13),
      surface: Color(0xfffff8f1),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffece1cf),
      onSurfaceVariant: Color(0xff292318),
      outline: Color(0xff494235),
      outlineVariant: Color(0xff494235),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff343027),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffffeabf),
      primaryFixed: Color(0xff554000),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3a2a00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff524100),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff382b00),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff2d492e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff17321a),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe2d9cc),
      surfaceBright: Color(0xfffff8f1),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffcf2e5),
      surfaceContainer: Color(0xfff6eddf),
      surfaceContainerHigh: Color(0xfff0e7d9),
      surfaceContainerHighest: Color(0xffeae1d4),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe6c26c),
      surfaceTint: Color(0xffe6c26c),
      onPrimary: Color(0xff3e2e00),
      primaryContainer: Color(0xff5a4400),
      onPrimaryContainer: Color(0xffffdf96),
      secondary: Color(0xffe2c46d),
      onSecondary: Color(0xff3c2f00),
      secondaryContainer: Color(0xff574500),
      onSecondaryContainer: Color(0xffffe087),
      tertiary: Color(0xffafcfab),
      onTertiary: Color(0xff1b361d),
      tertiaryContainer: Color(0xff314d32),
      onTertiaryContainer: Color(0xffcaebc6),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff17130b),
      onBackground: Color(0xffeae1d4),
      surface: Color(0xff17130b),
      onSurface: Color(0xffeae1d4),
      surfaceVariant: Color(0xff4d4639),
      onSurfaceVariant: Color(0xffd0c5b4),
      outline: Color(0xff999080),
      outlineVariant: Color(0xff4d4639),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae1d4),
      inverseOnSurface: Color(0xff343027),
      inversePrimary: Color(0xff755b0b),
      primaryFixed: Color(0xffffdf96),
      onPrimaryFixed: Color(0xff251a00),
      primaryFixedDim: Color(0xffe6c26c),
      onPrimaryFixedVariant: Color(0xff5a4400),
      secondaryFixed: Color(0xffffe087),
      onSecondaryFixed: Color(0xff241a00),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff574500),
      tertiaryFixed: Color(0xffcaebc6),
      onTertiaryFixed: Color(0xff05210a),
      tertiaryFixedDim: Color(0xffafcfab),
      onTertiaryFixedVariant: Color(0xff314d32),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff3d392f),
      surfaceContainerLowest: Color(0xff110e07),
      surfaceContainerLow: Color(0xff1f1b13),
      surfaceContainer: Color(0xff231f17),
      surfaceContainerHigh: Color(0xff2e2921),
      surfaceContainerHighest: Color(0xff39342b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffebc770),
      surfaceTint: Color(0xffe6c26c),
      onPrimary: Color(0xff1e1500),
      primaryContainer: Color(0xffac8d3d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe6c870),
      onSecondary: Color(0xff1d1500),
      secondaryContainer: Color(0xffa98e3d),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffb3d3b0),
      onTertiary: Color(0xff011b06),
      tertiaryContainer: Color(0xff7a9978),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff17130b),
      onBackground: Color(0xffeae1d4),
      surface: Color(0xff17130b),
      onSurface: Color(0xfffffaf6),
      surfaceVariant: Color(0xff4d4639),
      onSurfaceVariant: Color(0xffd4c9b8),
      outline: Color(0xffaba291),
      outlineVariant: Color(0xff8b8273),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae1d4),
      inverseOnSurface: Color(0xff2e2a21),
      inversePrimary: Color(0xff5b4500),
      primaryFixed: Color(0xffffdf96),
      onPrimaryFixed: Color(0xff181000),
      primaryFixedDim: Color(0xffe6c26c),
      onPrimaryFixedVariant: Color(0xff453400),
      secondaryFixed: Color(0xffffe087),
      onSecondaryFixed: Color(0xff171000),
      secondaryFixedDim: Color(0xffe2c46d),
      onSecondaryFixedVariant: Color(0xff433400),
      tertiaryFixed: Color(0xffcaebc6),
      onTertiaryFixed: Color(0xff001603),
      tertiaryFixedDim: Color(0xffafcfab),
      onTertiaryFixedVariant: Color(0xff213c23),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff3d392f),
      surfaceContainerLowest: Color(0xff110e07),
      surfaceContainerLow: Color(0xff1f1b13),
      surfaceContainer: Color(0xff231f17),
      surfaceContainerHigh: Color(0xff2e2921),
      surfaceContainerHighest: Color(0xff39342b),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf6),
      surfaceTint: Color(0xffe6c26c),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffebc770),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf6),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe6c870),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff0ffeb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffb3d3b0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff17130b),
      onBackground: Color(0xffeae1d4),
      surface: Color(0xff17130b),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff4d4639),
      onSurfaceVariant: Color(0xfffffaf6),
      outline: Color(0xffd4c9b8),
      outlineVariant: Color(0xffd4c9b8),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae1d4),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff362800),
      primaryFixed: Color(0xffffe4a9),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffebc770),
      onPrimaryFixedVariant: Color(0xff1e1500),
      secondaryFixed: Color(0xffffe59e),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe6c870),
      onSecondaryFixedVariant: Color(0xff1d1500),
      tertiaryFixed: Color(0xffcef0cb),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffb3d3b0),
      onTertiaryFixedVariant: Color(0xff011b06),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff3d392f),
      surfaceContainerLowest: Color(0xff110e07),
      surfaceContainerLow: Color(0xff1f1b13),
      surfaceContainer: Color(0xff231f17),
      surfaceContainerHigh: Color(0xff2e2921),
      surfaceContainerHighest: Color(0xff39342b),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
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
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class CustomTextTheme {
  TextTheme customTextTheme() {
    return TextTheme(
      displayLarge: displaylarge,
      displayMedium: displaymedium,
      displaySmall: displaysmall,
      headlineLarge: headlinelarge,
      headlineMedium: headlinemedium,
      headlineSmall: headlinesmall,
      titleLarge: titlelarge,
      titleMedium: titlemedium,
      titleSmall: titlesmall,
      bodyLarge: bodylarge,
      bodyMedium: bodymedium,
      bodySmall: bodysmall,
      labelLarge: labellarge,
      labelMedium: labelmedium,
      labelSmall: labelsmall,
    );
  }

  TextStyle get displaylarge => const TextStyle(
        fontSize: 57,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 64 / 57,
        letterSpacing: -0.25,
      );

  TextStyle get displaymedium => const TextStyle(
        fontSize: 45,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 52 / 45,
        letterSpacing: 0,
      );

  TextStyle get displaysmall => const TextStyle(
        fontSize: 36,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 44 / 36,
        letterSpacing: 0,
      );

  TextStyle get headlinelarge => const TextStyle(
        fontSize: 32,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 40 / 32,
        letterSpacing: 0,
      );

  TextStyle get headlinemedium => const TextStyle(
        fontSize: 28,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 36 / 28,
        letterSpacing: 0,
      );

  TextStyle get headlinesmall => const TextStyle(
        fontSize: 24,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 32 / 24,
        letterSpacing: 0,
      );

  TextStyle get titlelarge => const TextStyle(
        fontSize: 22,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
        letterSpacing: 0,
      );

  TextStyle get titlemedium => const TextStyle(
        fontSize: 16,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Medium',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 24 / 16,
        letterSpacing: 0.15,
      );

  TextStyle get titlesmall => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Medium',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.1,
      );

  TextStyle get bodylarge => const TextStyle(
        fontSize: 16,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: 0.5,
      );

  TextStyle get bodymedium => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: 0.25,
      );

  TextStyle get bodysmall => const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Regular',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        letterSpacing: 0.4,
      );

  TextStyle get labellargeprominent => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-SemiBold',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        height: 20 / 14,
        letterSpacing: 0.1,
      );

  TextStyle get labellarge => const TextStyle(
        fontSize: 14,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Medium',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.1,
      );

  TextStyle get labelmediumprominent => const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-SemiBold',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        height: 16 / 12,
        letterSpacing: 0.5,
      );

  TextStyle get labelmedium => const TextStyle(
        fontSize: 12,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Medium',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0.5,
      );

  TextStyle get labelsmall => const TextStyle(
        fontSize: 11,
        decoration: TextDecoration.none,
        fontFamily: 'Montserrat-Medium',
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 16 / 11,
        letterSpacing: 0.5,
      );
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
