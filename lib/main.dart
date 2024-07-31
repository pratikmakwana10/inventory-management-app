import 'package:flutter/material.dart';
import 'package:inventory_management_app/pages.dart/dashboard_pg.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Management',
      // this is simple
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color.fromARGB(255, 35, 167, 210),
          secondary: const Color.fromARGB(255, 11, 178, 66),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}
