import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:inventory_management_app/component/pie_chart.dart';
import 'package:inventory_management_app/pages.dart/invoice_pg.dart';
import 'package:inventory_management_app/pages.dart/product_pg.dart';
import 'package:inventory_management_app/pages.dart/recent_transection.dart';
import 'package:inventory_management_app/pages.dart/salesman_pg.dart';
import '../component/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Box productBox;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with the screen size of the context
    ScreenUtil.init(context, designSize: const Size(1440, 1024));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 167, 198),
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'MontserratAce'),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white, size: 24.sp),
      ),
      drawer: buildDrawer(context),
      drawerScrimColor: Colors.transparent.withOpacity(.7),
      body: Stack(
        children: [
          // Gradient Background
          Container(
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
          ),
          Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                // Sales and Purchases Row
                Row(
                  children: [
                    // Sales Section
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                        decoration: _commonBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "Sales",
                              style: TextStyle(color: Colors.white, fontSize: 20.sp),
                            ),
                            _buildOverviewRow(
                              card1: _buildOverviewCard(
                                'Stock Value',
                                '₹30,000',
                                Icons.store,
                                Colors.blue,
                              ),
                              card2: _buildOverviewCard(
                                'Week Sale',
                                '₹10,000',
                                Icons.weekend,
                                Colors.orange,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            // Add chart below the overview cards
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 350.h, // Adjusted height
                                    child: const PieChartSample3(),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                const Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [RecentTransactionsWidget()],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    // Purchases Section
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                        decoration: _commonBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Purchases",
                              style: TextStyle(color: Colors.white, fontSize: 20.sp),
                            ),
                            _buildOverviewRow(
                              card1: _buildOverviewCard(
                                'Stock Value',
                                '₹30,000',
                                Icons.store,
                                Colors.blue,
                              ),
                              card2: _buildOverviewCard(
                                'Week Purchase',
                                '₹10,000',
                                Icons.weekend,
                                Colors.orange,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            // Add chart below the overview cards
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 350.h, // Adjusted height
                                    child: const PieChartSample3(),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                const Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [RecentTransactionsWidget()],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Recent Transactions and Action Buttons
                // const RecentTransactionsWidget(),
                Center(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    // margin: EdgeInsets.only(bottom: 20.w),
                    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10),
                    decoration: _commonBoxDecoration(),
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          Icons.add_circle,
                          'Invoice',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const InvoicePg()),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        _buildActionButton(
                          Icons.add,
                          'Purchases',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SalesmanPg()),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        _buildActionButton(
                          Icons.trending_up,
                          'Sales',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SalesmanPg()),
                            );
                          },
                        ),
                        _buildActionButton(
                          Icons.inventory_2,
                          'Product',
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ProductPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildOverviewCard(String title, String value, [IconData? icon, Color? iconColor]) {
    return Container(
      height: 100.h, // Fixed height
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: _commonBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && iconColor != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: iconColor, size: 30.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                    Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
          if (icon == null || iconColor == null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                ),
                Text(
                  value,
                  style: TextStyle(color: Colors.black54, fontSize: 14.sp),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewRow({required Widget card1, required Widget card2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: card1),
        SizedBox(width: 10.w),
        Expanded(child: card2),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        ],
      ),
    );
  }
}
