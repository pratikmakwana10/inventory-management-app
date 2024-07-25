import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_app/component/bar_chart.dart';
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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 167, 198),
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      drawer: buildDrawer(context),
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _buildOverviewCard(
                                  'To Collect',
                                  '₹1,20,000',
                                  Icons.arrow_upward,
                                  Colors.green,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildOverviewCard(
                                  'To Pay',
                                  '₹50,000',
                                  Icons.arrow_downward,
                                  Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildOverviewCard(
                                  'Stock Value',
                                  '₹30,000',
                                  Icons.store,
                                  Colors.blue,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildOverviewCard(
                                  'Week Sale',
                                  '₹10,000',
                                  Icons.weekend,
                                  Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // width: MediaQuery.of(context).size.width / 3,
                      child: Card(
                        color: const Color.fromARGB(128, 175, 178, 177).withOpacity(0.15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Net Worth',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildCircle('To Collect', Colors.green),
                                  const SizedBox(width: 30),
                                  _buildCircle('To Pay', Colors.orange),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Pie Chart
                  ],
                ),
                const SizedBox(height: 30),
                // Business Names
                Row(
                  children: [
                    Column(
                      children: [
                        _buildBusinessName('Business 1', '25/07/2024', '₹5,000', true),
                        _buildBusinessName('Business 2', '24/07/2024', '₹7,000', false),
                        _buildBusinessName('Business 3', '23/07/2024', '₹10,000', true),
                        // Add more business names if needed
                      ],
                    ),
                    const Expanded(
                      child: PieChartSample3(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // Border radius
                        color: const Color.fromARGB(128, 0, 0, 0).withOpacity(0.15),
                      ), // Semi-transparent background
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ClientPage()),
                                );
                              },
                              child: const Text(
                                "View all",
                                style: TextStyle(color: Colors.white70),
                              )),
                          Column(
                            children: [
                              _buildBusinessName('Business 1', '25/07/2024', '₹5,000', true),
                              _buildBusinessName('Business 2', '24/07/2024', '₹7,000', false),
                              _buildBusinessName('Business 3', '23/07/2024', '₹10,000', true),
                              // Add more business names if needed
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const BarChartSample2(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String text, Color borderColor) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 4),
        color: const Color.fromARGB(0, 207, 56, 56),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: borderColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value, [IconData? icon, Color? iconColor]) {
    return Container(
      height: 80, // Fixed height

      margin: const EdgeInsets.symmetric(vertical: .0, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 175, 178, 177)
            .withOpacity(0.15), // Semi-transparent background
        borderRadius: BorderRadius.circular(10), // Border radius
        boxShadow: const [
          // Optional: shadow to add depth
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null && iconColor != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon, color: iconColor, size: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white, // Text color white
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Text color white
                      ),
                    ),
                  ],
                ),
              ],
            )
          else ...[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white, // Text color white
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white, // Text color white
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBusinessName(String businessName, String date, String amount, bool isToPay) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      decoration: BoxDecoration(
        color: const Color.fromARGB(128, 175, 178, 177)
            .withOpacity(0.15), // Semi-transparent background
        borderRadius: BorderRadius.circular(10), // Border radius
        boxShadow: const [
          // Optional: shadow to add depth
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin:
          const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0), // Reduced vertical margin
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20), // Reduced padding
      child: ListTile(
        contentPadding: EdgeInsets.zero, // Remove default padding
        leading: Icon(
          isToPay ? Icons.arrow_downward : Icons.arrow_upward,
          color: isToPay ? Colors.red : Colors.green, // Icon color based on the boolean value
          size: 20, // Reduced icon size
        ),
        title: Text(
          businessName,
          style: const TextStyle(
            fontSize: 15, // Reduced font size
            color: Colors.white, // Text color white
          ),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(
            fontSize: 12, // Reduced font size
            color: Colors.white70, // Slightly lighter text color
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isToPay ? Icons.arrow_downward : Icons.arrow_upward,
              color: isToPay ? Colors.red : Colors.green, // Icon color based on the boolean value
              size: 20, // Reduced icon size
            ),
            const SizedBox(width: 4), // Reduced space between icon and amount
            Text(
              amount,
              style: const TextStyle(
                fontSize: 16, // Reduced font size
                color: Colors.white, // Text color white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
