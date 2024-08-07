import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/product_model.dart'; // Adjust the path as needed
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
                  final products = box.values.toList();
                  _logger.i('Displaying ${products.length} products.');
                  return ListView.builder(
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
                          title: Text(product.productName,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Purchase Price: ₹${product.purchasePrice}',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Sale Price: ₹${product.salePrice}',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Quantity: ${product.quantity} ${product.unit}',
                                  style: const TextStyle(color: Colors.white)),
                              Text('Total Price: ₹$totalPrice',
                                  style: const TextStyle(color: Colors.white)),
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
                          trailing: IconButton(
                            icon: Image.asset(
                              'assets/trash.png',
                              // width: 44.w,
                              // height: 44.h,
                            ),
                            onPressed: () {
                              _removeProduct(index);
                            },
                          ),
                        ),
                      );
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
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Product'),
              contentPadding: const EdgeInsets.all(24.0), // Increased padding
              content: SizedBox(
                width: 600.w, // Adjust width as needed
                height: 500.h, // Adjust height as needed
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w, // Adjust label width
                          child: const Text('Product Name: '),
                        ),
                        Expanded(
                          child: TextField(
                            textCapitalization: TextCapitalization.sentences,
                            controller: productNameController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.w), // Adjust padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Adjust spacing
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w, // Adjust label width
                          child: const Text('Purchase Price: '),
                        ),
                        Expanded(
                          child: TextField(
                            controller: purchasePriceController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.w), // Adjust padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Adjust spacing
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w, // Adjust label width
                          child: const Text('Sale Price: '),
                        ),
                        Expanded(
                          child: TextField(
                            controller: salePriceController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.w), // Adjust padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Adjust spacing
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w, // Adjust label width
                          child: const Text('Quantity: '),
                        ),
                        Expanded(
                          child: TextField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.w), // Adjust padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Adjust spacing
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w, // Adjust label width
                          child: const Text('Category:'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: categoryController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.w), // Adjust padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Adjust spacing
                    Row(
                      children: [
                        SizedBox(
                          width: 150.w, // Adjust label width
                          child: const Text('Unit(gm):'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: unitController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(12.w), // Adjust padding
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Adjust spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('In Stock:'),
                        const SizedBox(
                          width: 60,
                        ),
                        Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: inStock,
                          onChanged: (bool? value) {
                            setState(() {
                              inStock = value ?? true;
                              _logger.i('In Stock status changed to: $inStock');
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
                    _logger.i('Add Product dialog cancelled.');
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Color.fromARGB(255, 93, 91, 91), fontSize: 20),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final productName = productNameController.text;
                    final purchasePrice = double.tryParse(purchasePriceController.text) ?? 0;
                    final salePrice = double.tryParse(salePriceController.text) ?? 0;
                    final quantity = int.tryParse(quantityController.text) ?? 0;
                    final category = categoryController.text;
                    final unit = unitController.text;

                    if (productName.isEmpty) {
                      _logger.w('Product name is empty. Cannot add product.');
                      return;
                    }

                    final product = Product(
                      productName: productName,
                      uniqueId: _generateUniqueId(),
                      purchasePrice: purchasePrice,
                      quantity: quantity,
                      category: category,
                      salePrice: salePrice,
                      unit: unit,
                      inStock: inStock,
                    );

                    setState(() {
                      productBox.add(product);
                      _logger
                          .i('Added product: ${product.productName} with ID: ${product.uniqueId}');
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Color.fromARGB(255, 93, 91, 91), fontSize: 20),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _generateUniqueId() {
    final id = Random().nextInt(100000).toString().padLeft(5, '0');
    _logger.i('Generated unique ID: $id');
    return id;
  }

  void _removeProduct(int index) {
    try {
      final product = productBox.getAt(index);
      if (product != null) {
        productBox.deleteAt(index);
        setState(() {});
      }
    } catch (e) {
      _logger.e('Failed to remove product at index $index: $e');
    }
  }
}
