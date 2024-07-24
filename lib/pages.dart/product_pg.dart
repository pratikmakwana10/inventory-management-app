import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [
    Product('Product 1', _generateUniqueId(), 100, 10, DateTime.now(), true),
    Product('Product 2', _generateUniqueId(), 200, 5,
        DateTime.now().subtract(const Duration(days: 1)), false),
    Product('Product 3', _generateUniqueId(), 150, 8,
        DateTime.now().subtract(const Duration(days: 2)), true),
  ];

  static String _generateUniqueId() {
    return Random().nextInt(100000).toString().padLeft(5, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final totalPrice = product.price * product.quantity;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(product.productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price: ₹${product.price}'),
                  Text('Quantity: ${product.quantity}'),
                  Text('Total Price: ₹$totalPrice'),
                  Text('Added on: ${DateFormat('yyyy-MM-dd').format(product.dateAdded)}'),
                  Text('Status: ${product.inStock ? 'In Stock' : 'Out of Stock'}'),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final productNameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController();
    final dateController = TextEditingController();
    bool inStock = true;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date Added (YYYY-MM-DD)'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('In Stock:'),
                  Checkbox(
                    activeColor: Colors.green, // Color of the checkbox when checked
                    checkColor: Colors.white, // Color of the checkmark
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
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final productName = productNameController.text;
                final price = double.tryParse(priceController.text) ?? 0;
                final quantity = int.tryParse(quantityController.text) ?? 0;
                final dateAdded = DateTime.tryParse(dateController.text) ?? DateTime.now();

                setState(() {
                  products.add(Product(
                      productName, _generateUniqueId(), price, quantity, dateAdded, inStock));
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
  final double price;
  final int quantity;
  final DateTime dateAdded;
  final bool inStock;

  Product(this.productName, this.uniqueId, this.price, this.quantity, this.dateAdded, this.inStock);
}