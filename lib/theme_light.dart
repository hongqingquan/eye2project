import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme.dart';

class BKThemeLight {
  BKThemeLight._();

  static const primary = Color(0xFF0099C2);
  static const secondary = Color(0xFF002846);

  static const white = Color(0xFFFFFFFF);
  static const backgournd = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF002846);
  static const textSecondary = Color(0xFF999999);

  static ThemeData get data => ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.standard,
        fontFamily: BKTheme.fontFamily,
        fontFamilyFallback: BKTheme.fontFamilyFallback,
        primaryColor: Colors.white,
        primaryColorLight: Colors.white,
        primaryColorDark: Colors.white,
        // scaffoldBackgroundColor: backgournd,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: white,
          primary: primary,
          onPrimary: white,
          primaryContainer: white,
          onPrimaryContainer: textPrimary,
          secondary: secondary,
          onSecondary: white,
          secondaryContainer: white,
          onSecondaryContainer: textPrimary,
          background: backgournd,
          onBackground: textPrimary,
          surface: white,
          onSurface: textPrimary,
          surfaceTint: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          toolbarHeight: 48,
          elevation: 0,
          scrolledUnderElevation: 0.8,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          shadowColor: Color(0x4D9E9E9E),
          iconTheme: IconThemeData(size: 18),
          titleTextStyle: TextStyle(
            color: textPrimary,
            height: 1.3,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: BKTheme.fontFamily,
            fontFamilyFallback: BKTheme.fontFamilyFallback,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemStatusBarContrastEnforced: false,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarContrastEnforced: false,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 6,
          backgroundColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: primary,
          unselectedItemColor: textPrimary,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            height: 1,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            height: 1,
            // fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            debugLabel: "theme titleLarge",
            fontWeight: FontWeight.normal,
            textBaseline: TextBaseline.ideographic,
            fontSize: 24,
            height: 1.02,
            color: textPrimary,
          ),
          titleMedium: TextStyle(
            debugLabel: "theme titleMedium",
            fontWeight: FontWeight.normal,
            textBaseline: TextBaseline.ideographic,
            fontSize: 16,
            height: 1.02,
            color: textPrimary,
          ),
          titleSmall: TextStyle(
            debugLabel: "theme titleSmall",
            fontWeight: FontWeight.normal,
            textBaseline: TextBaseline.ideographic,
            fontSize: 14,
            height: 1.02,
            color: textPrimary,
          ),
          bodyLarge: TextStyle(
            debugLabel: "theme bodyLarge",
            fontSize: 24,
            color: textPrimary,
          ),
          bodyMedium: TextStyle(
            debugLabel: "theme bodyMedium",
            fontSize: 16,
            color: textPrimary,
          ),
          bodySmall: TextStyle(
            debugLabel: "theme bodySmall",
            fontSize: 14,
            color: textPrimary,
          ),
        ),
      );
}
