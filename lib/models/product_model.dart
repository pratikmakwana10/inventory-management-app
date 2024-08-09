import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String uniqueId;
  @HiveField(1)
  final String productName;
  @HiveField(2)
  final double purchasePrice;
  @HiveField(3)
  final double salePrice;
  @HiveField(4)
  final int quantity;
  @HiveField(5)
  final bool inStock;

  Product({
    required this.uniqueId,
    required this.productName,
    required this.purchasePrice,
    required this.salePrice,
    required this.quantity,
    required this.inStock,
  });

  Product copyWith({
    String? uniqueId,
    String? productName,
    double? purchasePrice,
    double? salePrice,
    int? quantity,
    bool? inStock,
  }) {
    return Product(
      uniqueId: uniqueId ?? this.uniqueId,
      productName: productName ?? this.productName,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      salePrice: salePrice ?? this.salePrice,
      quantity: quantity ?? this.quantity,
      inStock: inStock ?? this.inStock,
    );
  }
}
