import 'package:alzpal_patient/FlashCards/widget/wrong_popup.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class FlashcardOption extends StatelessWidget {
  const FlashcardOption({super.key, required this.optionText});

  final String optionText;

  dynamic showPopUp(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'CLOSE',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ))
            ],
            backgroundColor: DarkBlack,
            content: WrongPopup(),
          );
        },
      );

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
                  horizontal: screenWidth * 0.25,
                  vertical: screenHeight * 0.0085),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              showPopUp(context);
            },
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
