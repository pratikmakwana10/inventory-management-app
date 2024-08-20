import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/product_adapter.dart';

import '../models/product_model.dart';

class HiveConfig {
  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductAdapter()); // Register other adapters if needed

    // Open Hive Boxes here
    await Hive.openBox<Product>('productBox'); // Register and open other boxes if needed
  }
}
