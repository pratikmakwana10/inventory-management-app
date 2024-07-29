import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

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
    this.textColor = const Color.fromARGB(255, 169, 169, 169),
    this.verticalPadding = 10,
    this.horizontalPadding = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 0),
      child: ClayContainer(
        spread: 2,
        customBorderRadius: const BorderRadius.only(topRight: Radius.circular(10)),
        emboss: true,
        color: Colors.grey[900],
        borderRadius: 10,
        depth: 50,
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: textColor)),
          onTap: onTap,
        ),
      ),
    );
  }
}
