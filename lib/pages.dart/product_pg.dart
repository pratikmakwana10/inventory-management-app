import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/product_model.dart';
import 'package:inventory_management_app/component/floating_button.dart';
import 'package:logger/logger.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Box<Product> productBox;
  final Logger _logger = Logger();
  bool isBoxLoaded = false;

  @override
  void initState() {
    super.initState();
    _openProductBox();
  }

  Future<void> _openProductBox() async {
    try {
      productBox = await Hive.openBox<Product>('productBox');
      _logger.i('Product box opened successfully.');
      setState(() {
        isBoxLoaded = true;
      });
    } catch (e) {
      _logger.e('Failed to open product box: $e');
    }
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
      body: isBoxLoaded
          ? Container(
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
              child: ValueListenableBuilder<Box<Product>>(
                valueListenable: productBox.listenable(),
                builder: (context, box, _) {
                  final products = box.values.toList().reversed.toList();
                  _logger.i('Displaying ${products.length} products.');
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductTile(product, index);
                    },
                  );
                },
              ),
            )
          : const Center(child: CircularProgressIndicator()),
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

  Widget _buildProductTile(Product product, int index) {
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
        title: Text(product.productName, style: const TextStyle(color: Colors.white, fontSize: 18)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Purchase Price: ₹${product.purchasePrice.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () => _updatePurchasePrice(index, -1),
                ),
                Text(product.purchasePrice.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white)),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () => _updatePurchasePrice(index, 1),
                ),
              ],
            ),
            Row(
              children: [
                Text('Sale Price: ₹${product.salePrice.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () => _updateSalePrice(index, -1),
                ),
                Text(product.salePrice.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white)),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () => _updateSalePrice(index, 1),
                ),
              ],
            ),
            Row(
              children: [
                Text('Quantity: ${product.quantity}', style: const TextStyle(color: Colors.white)),
                const Spacer(),
                Text(
                  'Status: ${product.inStock ? 'In Stock' : 'Out of Stock'}',
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
            Center(
              child: Text('Total Price: ₹${totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
        trailing: IconButton(
          icon: SvgPicture.asset(
            'assets/delete-icon.svg',
            width: 35.w,
            height: 35.h,
          ),
          onPressed: () => _removeProduct(product.uniqueId),
        ),
      ),
    );
  }

  void _updatePurchasePrice(int index, int change) {
    setState(() {
      final product = productBox.getAt(index);
      if (product != null) {
        final updatedProduct = product.copyWith(
          purchasePrice: max(product.purchasePrice + change, 0),
        );
        productBox.putAt(index, updatedProduct);
        _logger.i(
            'Updated Purchase Price for ${product.productName}: ${updatedProduct.purchasePrice}');
      }
    });
  }

  void _updateSalePrice(int index, int change) {
    setState(() {
      final product = productBox.getAt(index);
      if (product != null) {
        final updatedProduct = product.copyWith(
          salePrice: max(product.salePrice + change, 0),
        );
        productBox.putAt(index, updatedProduct);
        _logger.i('Updated Sale Price for ${product.productName}: ${updatedProduct.salePrice}');
      }
    });
  }

  void _removeProduct(String uniqueId) {
    setState(() {
      final productIndex =
          productBox.values.toList().indexWhere((product) => product.uniqueId == uniqueId);
      if (productIndex != -1) {
        final product = productBox.getAt(productIndex);
        if (product != null) {
          productBox.deleteAt(productIndex);
          _logger.i('Removed ${product.productName} from the product list.');
          _updateRecentTransactions(); // Notify DashboardScreen
        }
      }
    });
  }

  void _showAddProductDialog(BuildContext context) {
    final productNameController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();
    final quantityController = TextEditingController();
    bool inStock = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Product'),
              contentPadding: const EdgeInsets.all(24.0),
              content: SizedBox(
                width: 600.w,
                height: 400.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: const Text('Product Name:'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: productNameController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: const Text('Purchase Price:'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: purchasePriceController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: const Text('Sale Price:'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: salePriceController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: const Text('Quantity:'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: quantityController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text('In Stock:'),
                        Switch(
                          value: inStock,
                          onChanged: (value) {
                            setState(() {
                              inStock = value;
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
                  onPressed: () {
                    final newProduct = Product(
                      uniqueId: _generateUniqueId(),
                      productName: productNameController.text,
                      purchasePrice: double.tryParse(purchasePriceController.text) ?? 0,
                      salePrice: double.tryParse(salePriceController.text) ?? 0,
                      quantity: int.tryParse(quantityController.text) ?? 0,
                      inStock: inStock,
                    );
                    productBox.add(newProduct);
                    Navigator.of(context).pop();
                    _logger.i('Added new product: ${newProduct.productName}');
                    _updateRecentTransactions(); // Notify DashboardScreen
                  },
                  child: const Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _generateUniqueId() {
    final rng = Random();
    int uniqueId;
    do {
      uniqueId = rng.nextInt(100000);
    } while (productBox.values.any((product) => product.uniqueId == uniqueId));
    return uniqueId.toString();
  }

  void _updateRecentTransactions() {
    // Implement a method to notify the DashboardScreen or any other page to update recent transactions.
    // This could be done using a state management solution or by triggering a callback.
  }
}
