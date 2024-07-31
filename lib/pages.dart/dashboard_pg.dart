import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_app/component/pie_chart.dart';
import 'package:inventory_management_app/pages.dart/client_pg.dart';
import '../component/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedMonth = 'July';
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil with the screen size of the context
    ScreenUtil.init(context, designSize: const Size(1440, 1024));

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 167, 198),
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontSize: 24.sp),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: _commonBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Sales",
                              style: TextStyle(color: Colors.white, fontSize: 20.sp),
                            ),
                            SizedBox(height: 10.h),
                            _buildOverviewRow(),
                            SizedBox(height: 16.h),
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10.w),
                        padding: EdgeInsets.all(10.w),
                        decoration: _commonBoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildActionButton(Icons.add_circle, 'Create Invoice'),
                            _buildActionButton(Icons.add, 'Add Purchases'),
                            _buildActionButton(Icons.trending_up, 'Add Sales'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: _commonBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Purchases",
                              style: TextStyle(color: Colors.white, fontSize: 20.sp),
                            ),
                            SizedBox(height: 10.h),
                            _buildOverviewRow(),
                            SizedBox(height: 16.h),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                // Business Names
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: _commonBoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    child: Text(
                                      "  Sales",
                                      style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ClientPage()),
                                      );
                                    },
                                    child: Text(
                                      "View all",
                                      style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildBusinessName('Business 1', '25/07/2024', '₹5,000', true),
                                  _buildBusinessName('Business 2', '24/07/2024', '₹7,000', false),
                                  _buildBusinessName('Business 3', '23/07/2024', '₹10,000', true),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Sales",
                              style: TextStyle(color: Colors.white),
                            ),
                            PieChartSample3(),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Purchase",
                              style: TextStyle(color: Colors.white),
                            ),
                            PieChartSample3(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: _commonBoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "    Purchases",
                                    style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ClientPage()),
                                      );
                                    },
                                    child: Text(
                                      "View all",
                                      style: TextStyle(color: Colors.white70, fontSize: 18.sp),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  _buildBusinessName('Business 1', '25/07/2024', '₹5,000', true),
                                  _buildBusinessName('Business 2', '24/07/2024', '₹7,000', false),
                                  _buildBusinessName('Business 3', '23/07/2024', '₹10,000', true),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                // Action Buttons
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
      height: 80.h, // Fixed height
      margin: EdgeInsets.symmetric(vertical: .0.h, horizontal: 10.w),
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.white, // Text color white
                      ),
                    ),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white, // Text color white
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewRow({Widget? card1, Widget? card2}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: card1 ??
              _buildOverviewCard(
                'To Collect',
                '₹1,20,000',
                Icons.arrow_upward,
                Colors.green,
              ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: card2 ??
              _buildOverviewCard(
                'To Pay',
                '₹50,000',
                Icons.arrow_downward,
                Colors.red,
              ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return TextButton(
      onPressed: () {
        // Handle button press
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white, padding: EdgeInsets.all(8.w), // Add padding if needed
        backgroundColor: Colors.transparent, // Text color
        splashFactory: InkSplash.splashFactory, // Use splash effect
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Icon(icon, size: 30.sp, color: Colors.white),
            SizedBox(height: 4.h), // Add spacing between icon and text
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessName(String name, String date, String value, bool isPaid) {
    return Container(
      margin: EdgeInsets.all(10.w),
      padding: EdgeInsets.all(10.w),
      decoration: _commonBoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: TextStyle(color: Colors.white70, fontSize: 12.sp),
              ),
              Text(
                value,
                style: TextStyle(
                  color: isPaid ? Colors.green : Colors.red,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
