import 'package:alzpal_patient/ClockGame/widget/wrong_popup.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class ClockOption extends StatelessWidget {
  const ClockOption(
      {super.key,
      required this.optionText,
      this.isSelected = false,
      this.isCorrect = false});

  final String optionText;
  final bool isSelected;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.32, vertical: screenHeight * 0.0085),
          decoration: BoxDecoration(
            color: isSelected
                ? isCorrect
                    ? GreenColor
                    : Colors.red
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? isCorrect
                      ? GreenColor
                      : Colors.red
                  : GreenColor,
            ),
          ),
          child: Text(
            isSelected ? (isCorrect ? 'CORRECT' : 'WRONG') : optionText,
            style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
