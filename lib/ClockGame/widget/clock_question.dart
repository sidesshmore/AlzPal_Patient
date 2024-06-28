import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class ClockQuestion extends StatelessWidget {
  const ClockQuestion({super.key,required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.45,
      width: screenWidth * 0.916,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: DarkBlack,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What is the time?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Image.asset(
            imageUrl,
            width: screenWidth * 0.65,
            height: screenHeight * 0.3,
          ),
        ],
      ),
    );
  }
}
