import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poke_mon/presentation/util/appFont/app_font.dart';

const Color _kPrimaryLightColor = Color(0xFF006B5A);
const Color _kPrimaryDarkColor = Colors.red;
const Color _kBackgroundDarkColor = Color(0xFF010101);
const Color _kBackgroundWhiteColor = Colors.white;
const double _kIconSize = 25.0;

class AppColorTheme {
  const AppColorTheme._();
}

class AppTheme extends ThemeExtension<AppTheme> {
  const AppTheme._();

  final AppColorTheme color = const AppColorTheme._();

  @override
  ThemeExtension<AppTheme> copyWith() => this;

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) =>
      this;
}

ThemeData themeBuilder(
  ThemeData defaultTheme, {
  AppTheme appTheme = const AppTheme._(),
}) {
  final Brightness brightness = defaultTheme.brightness;
  final bool isDark = brightness == Brightness.dark;

  //Style App Color Scheme
  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: isDark ? _kPrimaryDarkColor : _kPrimaryLightColor,
    brightness: brightness,
  );
  final Color scaffoldBackgroundColor =
      isDark ? _kBackgroundDarkColor : colorScheme.background;

  //Style TextInput Color
  const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );
  final OutlineInputBorder textFieldErrorBorder = textFieldBorder.copyWith(
    borderSide: BorderSide(color: colorScheme.error),
  );

  //Style Text textstyle
  final TextTheme textTheme = defaultTheme.textTheme.apply(
      fontFamily: kAppFontFamily,
      displayColor: isDark ? _kBackgroundWhiteColor : _kBackgroundDarkColor);

//Style Card
  final CardTheme cardTheme = defaultTheme.cardTheme.copyWith(
      color: colorScheme.background,
      elevation: 1,
      shadowColor: Colors.grey.shade100);
//Style AppBar
  final AppBarTheme appBarTheme = defaultTheme.appBarTheme.copyWith(
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      systemOverlayStyle:
          isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);
  //Style button textstyle
  final TextStyle? buttonTextStyle = textTheme.labelMedium?.copyWith(
      fontWeight: AppFontWeight.semibold,
      fontSize: 20,
      color: isDark ? _kBackgroundWhiteColor : _kBackgroundDarkColor);
  final ButtonStyle buttonStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(buttonTextStyle),
    elevation: MaterialStateProperty.all(0),
  );

//Style Chip label textstyle
  final TextStyle? chipTextStyle = textTheme.bodyMedium?.copyWith(
    fontWeight: AppFontWeight.light,
    fontSize: 13,
    color: isDark ? Colors.black : _kBackgroundDarkColor,
  );
  //Style Chip backgroundColor
  final Color chipColor =
      isDark ? colorScheme.onBackground : colorScheme.outline.withOpacity(0.1);

  return ThemeData(
    useMaterial3: true,
    cardTheme: cardTheme,
    appBarTheme: appBarTheme,
    chipTheme: defaultTheme.chipTheme
        .copyWith(backgroundColor: chipColor, labelStyle: chipTextStyle),
    iconTheme: defaultTheme.iconTheme.copyWith(size: _kIconSize),
    primaryIconTheme: defaultTheme.primaryIconTheme.copyWith(size: _kIconSize),
    textTheme: defaultTheme.textTheme.merge(textTheme),
    primaryTextTheme: defaultTheme.primaryTextTheme.merge(textTheme),
    shadowColor: colorScheme.scrim,
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    textButtonTheme: TextButtonThemeData(style: buttonStyle),
    filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: colorScheme.onPrimary,
      foregroundColor: colorScheme.onBackground,
    ),
    colorScheme: colorScheme,
    inputDecorationTheme: InputDecorationTheme(
      border: textFieldBorder,
      focusedBorder: textFieldBorder,
      enabledBorder: textFieldBorder,
      errorBorder: textFieldErrorBorder,
      focusedErrorBorder: textFieldErrorBorder,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      filled: true,
    ),
    fontFamily: kAppFontFamily,
  );
}
