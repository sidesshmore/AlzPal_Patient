import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class FlashcardQuestion extends StatefulWidget {
  const FlashcardQuestion({super.key});

  @override
  State<FlashcardQuestion> createState() => _FlashcardQuestionState();
}

class _FlashcardQuestionState extends State<FlashcardQuestion> {
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
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              width: screenWidth * 0.7,
              height: screenHeight * 0.3,
              fit: BoxFit.fill,
              'assets/tomato.jpg',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'What is this?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }
}
