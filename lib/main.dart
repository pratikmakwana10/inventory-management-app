import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/product_adapter.dart';
import 'package:inventory_management_app/pages.dart/dashboard_pg.dart';
import 'models/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open boxes
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter()); // Register your adapter
  await Hive.openBox<Product>('productsBox'); // Use the correct box name and type

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (context, child) {
        return MaterialApp(
          title: 'Inventory Management',
          theme: _buildAppTheme(),
          home: const DashboardScreen(),
        );
      },
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      textTheme: const TextTheme(
        bodyLarge: TextStyle(fontFamily: 'MontserratAce'),
        bodyMedium: TextStyle(fontFamily: 'MontserratAce'),
        displayLarge: TextStyle(fontFamily: 'MontserratAce'),
        displayMedium: TextStyle(fontFamily: 'MontserratAce'),
        displaySmall: TextStyle(fontFamily: 'MontserratAce'),
        headlineLarge: TextStyle(fontFamily: 'MontserratAce'),
        headlineMedium: TextStyle(fontFamily: 'MontserratAce'),
        headlineSmall: TextStyle(fontFamily: 'MontserratAce'),
        titleMedium: TextStyle(fontFamily: 'MontserratAce'),
        titleSmall: TextStyle(fontFamily: 'MontserratAce'),
        bodySmall: TextStyle(fontFamily: 'MontserratAce'),
        labelLarge: TextStyle(fontFamily: 'MontserratAce'),
        labelSmall: TextStyle(fontFamily: 'MontserratAce'),
      ),
      primaryColor: const Color.fromARGB(255, 47, 165, 189),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 24),
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 21, 117, 141),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 4, 116, 208),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 4, 116, 208),
          ),
        ),
        labelStyle: TextStyle(color: Color.fromARGB(255, 4, 116, 208)),
      ),
    );
  }
}

BoxDecoration commonBoxDecoration() {
  return BoxDecoration(
    color: const Color.fromARGB(128, 175, 178, 177).withOpacity(0.15),
    borderRadius: BorderRadius.circular(10.r),
    boxShadow: const [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 4,
        offset: Offset(0, 2),
      ),
    ],
  );
}
