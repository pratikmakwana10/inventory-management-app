import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:inventory_management_app/models/product_model.dart';
import 'package:logger/logger.dart';

class RecentTransactionsWidget extends StatefulWidget {
  const RecentTransactionsWidget({super.key});

  @override
  _RecentTransactionsWidgetState createState() => _RecentTransactionsWidgetState();
}

class _RecentTransactionsWidgetState extends State<RecentTransactionsWidget> {
  late Box<Product> productBox;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    _openProductBox();
  }

  Future<void> _openProductBox() async {
    try {
      productBox = await Hive.openBox<Product>('productBox');
      _logger.i('Product box opened successfully.');
      setState(() {});
    } catch (e) {
      _logger.e('Failed to open product box: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ValueListenableBuilder<Box<Product>>(
      valueListenable: productBox.listenable(),
      builder: (context, box, _) {
        final products = box.values.toList().reversed.take(3).toList(); // Take the last 3 products

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          padding: EdgeInsets.all(10.w),
          decoration: _commonBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
                child: Text(
                  'Recent Transactions',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    decoration: _commonBoxDecoration(),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        product.productName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Quantity: ${product.quantity}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        '₹${product.salePrice}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration _commonBoxDecoration() {
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
}
