import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class ClockOption extends StatelessWidget {
  const ClockOption({super.key, required this.optionText});

  final String optionText;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: GreenColor),
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.32,
                  vertical: screenHeight * 0.0085),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {},
            child: Text(
              optionText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}
