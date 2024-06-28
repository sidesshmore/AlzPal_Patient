import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/Square%20Tap/data/colorData.dart';
import 'package:alzpal_patient/Square%20Tap/widgets/square_check.dart';
import 'package:alzpal_patient/Square%20Tap/widgets/square_container.dart';
import 'package:alzpal_patient/Square%20Tap/widgets/square_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SquareTap extends StatefulWidget {
  const SquareTap({super.key});

  @override
  State<SquareTap> createState() => _SquareTapState();
}

class _SquareTapState extends State<SquareTap> {
  var colorIndex = 0;
  bool isCorrect = false;
  bool isSelected = false;

  List shuffledColor = List.of(colorsData);

  List<Color> colors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.red,
    Colors.green,
    Colors.white,
  ];
  int currentColorIndex = 0;

  // Function to change the color
  void changeColor() {
    setState(() {
      currentColorIndex = (currentColorIndex + 1) % colors.length;
    });
  }

  @override
  void initState() {
    shuffledColor.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'Square Tap'),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [SquareQuestion(color: shuffledColor[colorIndex])],
            ),
            SizedBox(
              height: screenHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: changeColor,
                    child: SquareContainer(
                      color: colors[currentColorIndex],
                    ))
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isCorrect = shuffledColor[colorIndex].color ==
                          colors[currentColorIndex];
                      isSelected = true;
                    });

                    if (isCorrect) {
                      HapticFeedback.lightImpact();
                      Future.delayed(Duration(seconds: 1), () {
                        if (colorIndex == shuffledColor.length - 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }),
                          );
                        } else {
                          setState(() {
                            colorIndex++;
                            isSelected = false;
                          });
                        }
                      });
                    } else {
                      HapticFeedback.heavyImpact();
                      Future.delayed(Duration(seconds: 1), () {
                        setState(() {
                          isSelected = false;
                        });
                      });
                    }
                  },
                  child: SquareCheck(
                    optionText: 'CHECK',
                    isCorrect: isCorrect,
                    isSelected: isSelected,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
