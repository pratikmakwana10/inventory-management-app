import 'package:flutter/material.dart';

Widget commonListTile({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white, // White icon color
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white, // White text color
      ),
    ),
    onTap: onTap,
  );
}
