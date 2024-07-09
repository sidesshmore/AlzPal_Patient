
import 'package:alzpal_patient/Profile/ui/profileScreen.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/cupertino.dart';
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
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Icon(
              CupertinoIcons.person_solid,
              size: screenWidth * 0.07,
              color: GreenColor,
            ),
          ),
        )
      ],
    );
  }
}
