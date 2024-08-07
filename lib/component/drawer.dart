import 'package:flutter/material.dart';
import 'package:inventory_management_app/component/listtile_dashboard.dart';
import 'package:inventory_management_app/pages.dart/salesman_pg.dart';
import 'package:inventory_management_app/pages.dart/invoice_pg.dart';
import 'package:inventory_management_app/pages.dart/product_pg.dart';
import 'package:inventory_management_app/pages.dart/report_pg.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
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
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.transparent, // Make the DrawerHeader background transparent
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/credit-card-payment.png',
                  width: 100,
                  height: 100,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          DrawerListTile(
            icon: Icons.shopping_cart,
            title: 'Product',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
            },
          ),
          DrawerListTile(
            icon: Icons.person,
            title: 'Clients',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SlaesmanPg()),
              );
            },
          ),
          DrawerListTile(
            icon: Icons.bar_chart,
            title: 'Reports',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportPage()),
              );
            },
          ),
          DrawerListTile(
            icon: Icons.receipt,
            title: 'Invoices',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const InvoicePg()),
              );
            },
          ),
          // Add more navigation items
        ],
      ),
    ),
  );
}
