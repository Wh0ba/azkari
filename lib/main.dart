import 'package:azkari/pages/navbar_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Azkari',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xffEAE0D5),
          background: Color(0xFF212322),
          onPrimary: Color(0xffEAE0D5),
          surfaceTint: Color(0xff702632),
          shadow: Color(0xff702632),
          surface: Color(0xff702632),
        ),
        highlightColor: const Color(0xff702632),
        splashColor: const Color(0xff702632),
        useMaterial3: true,
      ),
      home: const NavBarPage(),
    );
  }
}
