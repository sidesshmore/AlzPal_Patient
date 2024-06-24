import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/ClockGame/widget/clock_option.dart';
import 'package:alzpal_patient/ClockGame/widget/clock_question.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class ClockGame extends StatefulWidget {
  const ClockGame({super.key});

  @override
  State<ClockGame> createState() => _ClockGameState();
}

class _ClockGameState extends State<ClockGame> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'Clock Game'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClockQuestion(),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            ClockOption(
              optionText: '12:15',
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            ClockOption(
              optionText: '3:00',
            ),
          ],
        ),
      ),
    );
  }
}
