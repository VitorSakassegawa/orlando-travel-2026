import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrlandoTheme {
  // Sage & Sand Palette
  static const Color sageDark = Color(0xFF3F5E42);
  static const Color sage = Color(0xFF7A9E7E);
  static const Color sageLight = Color(0xFFA3C4A6);
  static const Color paper = Color(0xFFF7F5F0);
  static const Color sand = Color(0xFFE3DDD2);
  static const Color ink = Color(0xFF1A1F16);
  static const Color terracotta = Color(0xFFC2694A);
  static const Color gold = Color(0xFFC19A3E);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: sageDark,
        primary: sageDark,
        secondary: sage,
        surface: paper,
        background: paper,
        onSurface: ink,
      ),
      scaffoldBackgroundColor: paper,
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.w900,
          color: ink,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontWeight: FontWeight.bold,
          color: ink,
        ),
        titleLarge: GoogleFonts.dmSans(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: ink,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 60, // Critical Correction #1
        iconTheme: IconThemeData(color: ink),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: sageDark,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: sageLight,
        brightness: Brightness.dark,
        primary: sageLight,
        secondary: sage,
        surface: const Color(0xFF121511),
        background: const Color(0xFF121511),
        onSurface: const Color(0xFFF0F4EE),
      ),
      scaffoldBackgroundColor: const Color(0xFF121511),
      textTheme: GoogleFonts.dmSansTextTheme().apply(
        bodyColor: const Color(0xFFF0F4EE),
        displayColor: const Color(0xFFF0F4EE),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60, // Critical Correction #1
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0F120D),
        selectedItemColor: sageLight,
        unselectedItemColor: Colors.grey,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E261F),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
