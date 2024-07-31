import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_app/component/floating_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [
    Product('Wheat Bread', _generateUniqueId(), 100, 10, 'Category 1', 120, 'kg', true),
    Product('Garlic Bread', _generateUniqueId(), 200, 5, 'Category 2', 250, 'gram', false),
    Product('Burger Bread', _generateUniqueId(), 150, 8, 'Category 3', 180, 'kg', true),
  ];

  static String _generateUniqueId() {
    return Random().nextInt(100000).toString().padLeft(5, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(color: Colors.white, fontSize: 24.sp),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
      ),
      drawerScrimColor: Colors.transparent.withOpacity(.7),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 4, 116, 208),
              Color.fromARGB(255, 4, 147, 113),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final totalPrice = product.salePrice * product.quantity;
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(128, 175, 178, 177).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                title: Text(product.productName, style: const TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Purchase Price: ₹${product.purchasePrice}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Sale Price: ₹${product.salePrice}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Quantity: ${product.quantity} ${product.unit}',
                        style: const TextStyle(color: Colors.white)),
                    Text('Total Price: ₹$totalPrice', style: const TextStyle(color: Colors.white)),
                    Text('Category: ${product.category}',
                        style: const TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        const Text("Status:", style: TextStyle(color: Colors.white)),
                        Text(
                          ' ${product.inStock ? 'In Stock' : 'Out of Stock'}',
                          style: TextStyle(
                            color: product.inStock
                                ? const Color.fromARGB(255, 91, 255, 96)
                                : const Color.fromARGB(255, 255, 0, 0),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: GradientFloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        icon: Icons.add,
        gradientColors: const [
          Color.fromARGB(255, 4, 208, 208),
          Color.fromARGB(255, 2, 110, 85),
        ],
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final productNameController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();
    final quantityController = TextEditingController();
    final categoryController = TextEditingController();
    final unitController = TextEditingController();
    bool inStock = true;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(labelText: 'Product Name'),
                ),
                TextField(
                  controller: purchasePriceController,
                  decoration: const InputDecoration(labelText: 'Purchase Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: salePriceController,
                  decoration: const InputDecoration(labelText: 'Sale Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantityController,
                  decoration: const InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: unitController,
                  decoration: const InputDecoration(labelText: 'Unit (e.g., kg, gram)'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('In Stock:'),
                    Checkbox(
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      value: inStock,
                      onChanged: (bool? value) {
                        setState(() {
                          inStock = value ?? true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final productName = productNameController.text;
                final purchasePrice = double.tryParse(purchasePriceController.text) ?? 0;
                final salePrice = double.tryParse(salePriceController.text) ?? 0;
                final quantity = int.tryParse(quantityController.text) ?? 0;
                final category = categoryController.text;
                final unit = unitController.text;

                setState(() {
                  products.add(Product(productName, _generateUniqueId(), purchasePrice, quantity,
                      category, salePrice, unit, inStock));
                });

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String productName;
  final String uniqueId;
  final double purchasePrice;
  final int quantity;
  final String category;
  final double salePrice;
  final String unit;
  final bool inStock;

  Product(
    this.productName,
    this.uniqueId,
    this.purchasePrice,
    this.quantity,
    this.category,
    this.salePrice,
    this.unit,
    this.inStock,
  );
}
