import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrlandoTheme {
  // Palette from HTML Design System
  static const Color ink = Color(0xFF1A1F16);
  static const Color inkSoft = Color(0xFF2D3328);
  static const Color paper = Color(0xFFF5F2EC);
  static const Color sand = Color(0xFFE3DDD2);
  static const Color sage = Color(0xFF7A9E7E);
  static const Color sageDark = Color(0xFF3F5E42);
  static const Color sageLight = Color(0xFFA3C4A6);
  static const Color sageMist = Color(0xFFDCE8DD);
  static const Color sageWash = Color(0xFFEEF3EE);
  
  static const Color terracotta = Color(0xFFC2694A);
  static const Color sky = Color(0xFF5B9BC5);
  static const Color gold = Color(0xFFC19A3E);
  static const Color coral = Color(0xFFD45D5D);

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: sageDark,
        background: paper,
        onBackground: ink,
        primary: sageDark,
        secondary: terracotta,
      ),
      scaffoldBackgroundColor: paper,
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w900, color: ink),
        displayMedium: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700, color: ink),
        titleLarge: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: ink),
        labelMedium: GoogleFonts.jetbrainsMono(letterSpacing: 2.0, fontSize: 10, color: sageDark),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(
          color: ink,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xE0F7F5F0), // Glassy whiteish
        selectedItemColor: sageDark,
        unselectedItemColor: inkSoft,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.9),
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0x1F000000)),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: sageLight,
        brightness: Brightness.dark,
        background: const Color(0xFF121511),
        onBackground: const Color(0xFFF0F4EE),
        primary: sageLight,
        secondary: terracotta,
      ),
      scaffoldBackgroundColor: const Color(0xFF121511),
      textTheme: GoogleFonts.dmSansTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w900, color: Colors.white),
        displayMedium: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w700, color: Colors.white),
        titleLarge: GoogleFonts.dmSans(fontWeight: FontWeight.w700, color: Colors.white),
        labelMedium: GoogleFonts.jetbrainsMono(letterSpacing: 2.0, fontSize: 10, color: sageLight),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xE00F120D), // Glassy blackish
        selectedItemColor: sageLight,
        unselectedItemColor: Colors.grey,
      ),
      cardTheme: CardThemeData(
        color: const Color(0xFF1E261F).withOpacity(0.85),
        elevation: 8,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0x33FFFFFF)),
        ),
      ),
    );
  }
}
