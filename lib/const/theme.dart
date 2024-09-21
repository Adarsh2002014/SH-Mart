import 'package:shmart/shmart.dart';

ThemeData lightTheme = ThemeData(

    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: "Inconsolata",
    colorScheme: ColorScheme.fromSeed(
        seedColor: mainSeedColor, brightness: Brightness.light),
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18)))),
    textTheme: const TextTheme(
        labelSmall: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w200, color: black87),
        labelMedium: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w300, color: black87),
        labelLarge: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: black87),
        bodySmall: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: black87),
        bodyMedium: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w600, color: black87),
        bodyLarge: TextStyle(
            fontSize: 24, fontWeight: FontWeight.w700, color: black87),
        displaySmall: TextStyle(
            fontSize: 28, fontWeight: FontWeight.w800, color: black87),
        displayMedium: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w900, color: black87)));

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: "Inconsolata",
    colorScheme: ColorScheme.fromSeed(
        seedColor: mainSeedColor, brightness: Brightness.dark),
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18)))),
    textTheme: const TextTheme(
        labelSmall:
            TextStyle(fontSize: 15, fontWeight: FontWeight.w200, color: white),
        labelMedium:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: white),
        labelLarge:
            TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: white),
        bodySmall:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: white),
        bodyMedium:
            TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: white),
        bodyLarge:
            TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: white),
        displaySmall:
            TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: white),
        displayMedium: TextStyle(
            fontSize: 32, fontWeight: FontWeight.w900, color: white)));
