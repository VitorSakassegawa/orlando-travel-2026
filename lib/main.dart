import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'orlando_theme.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase Initialization (using credentials found in index.html)
  await Supabase.initialize(
    url: 'https://ddaknngajhdywtsqzctn.supabase.co',
    anonKey: 'sb_publishable_gQ6FHkORr2kBv0r74wT7AQ_3tbhUek1',
  );

  runApp(
    const ProviderScope(
      child: OrlandoApp(),
    ),
  );
}

class OrlandoApp extends StatelessWidget {
  const OrlandoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orlando 2026',
      debugShowCheckedModeBanner: false,
      theme: OrlandoTheme.lightTheme(),
      darkTheme: OrlandoTheme.darkTheme(),
      themeMode: ThemeMode.system, // Auto dark/light
      home: const MainScreen(),
    );
  }
}
