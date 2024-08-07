import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final double verticalPadding;
  final double horizontalPadding;

  const DrawerListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = const Color.fromARGB(255, 169, 169, 169),
    this.textColor = const Color.fromARGB(255, 255, 253, 253),
    this.verticalPadding = 10,
    this.horizontalPadding = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey[900], // Background color
          borderRadius: BorderRadius.circular(10), // Border radius
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: textColor)),
          onTap: onTap,
        ),
      ),
    );
  }
}
