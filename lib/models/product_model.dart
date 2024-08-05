import 'package:hive/hive.dart';

@HiveType(typeId: 0) // Ensure this typeId is unique
class Product {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final String uniqueId;

  @HiveField(2)
  final double purchasePrice;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final double salePrice;

  @HiveField(6)
  final String unit;

  @HiveField(7)
  final bool inStock;

  Product({
    required this.productName,
    required this.uniqueId,
    required this.purchasePrice,
    required this.quantity,
    required this.category,
    required this.salePrice,
    required this.unit,
    required this.inStock,
  });
}
