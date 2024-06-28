import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class WrongPopup extends StatelessWidget {
  const WrongPopup({super.key,required this.imageUrl,required this.answer});

  final String imageUrl;
  final String answer;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.577,
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
                'Oops!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Image.asset(
            imageUrl,
            width: screenWidth * 0.65,
            height: screenHeight * 0.3,
          ),
          RichText(
            text: TextSpan(
                text: 'It is ',
                style: TextStyle(
                    fontSize: screenWidth * 0.1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: answer,
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.w600,
                      color: GreenColor,
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
    ;
  }
}
