import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/app_router.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kartu Profil Digital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      routerConfig: appRouter, // Konfigurasi GoRouter (Lab 8.5)
    );
  }
}
