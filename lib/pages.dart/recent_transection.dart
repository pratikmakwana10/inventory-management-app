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
    return ValueListenableBuilder<Box<Product>>(
      valueListenable: Hive.box<Product>('productBox').listenable(),
      builder: (context, box, _) {
        final products = box.values.toList();
        products.sort((a, b) =>
            b.uniqueId.compareTo(a.uniqueId)); // Sort by uniqueId to get the latest transactions
        final recentTransactions = products.take(3).toList();

        return Container(
          height: 300.h, // Fixed height for the container
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
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recentTransactions.length,
                  itemBuilder: (context, index) {
                    final product = recentTransactions[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(128, 175, 178, 177).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          product.productName,
                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                        subtitle: Text(
                          'Quantity: ${product.quantity} ${product.unit}',
                          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                        ),
                        trailing: Text(
                          '₹${product.salePrice * product.quantity}',
                          style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        ),
                      ),
                    );
                  },
                ),
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
