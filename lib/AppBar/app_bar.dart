import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.MyAppBarHeading});

  final String MyAppBarHeading;

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
      foregroundColor: Colors.white,
      title: Text(
        MyAppBarHeading,
        style: TextStyle(
            fontSize: screenWidth * 0.08,
            fontWeight: FontWeight.w700,
            color: GreenColor),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: Icon(
            Icons.sunny,
            size: screenWidth * 0.083,
            color: GreenColor,
          ),
        )
      ],
    );
  }
}
