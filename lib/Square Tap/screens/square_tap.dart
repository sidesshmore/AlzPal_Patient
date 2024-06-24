import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/Square%20Tap/widgets/square_container.dart';
import 'package:alzpal_patient/Square%20Tap/widgets/square_question.dart';
import 'package:flutter/material.dart';

class SquareTap extends StatefulWidget {
  const SquareTap({super.key});

  @override
  State<SquareTap> createState() => _SquareTapState();
}

class _SquareTapState extends State<SquareTap> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'Square Tap'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.07,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SquareQuestion()],
            ),
            SizedBox(
              height: screenHeight * 0.15,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SquareContainer()],
            ),
          ],
        ),
      ),
    );
  }
}
