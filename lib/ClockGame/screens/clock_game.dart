import 'dart:developer';

import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/ClockGame/data/questions.dart';
import 'package:alzpal_patient/ClockGame/widget/clock_option.dart';
import 'package:alzpal_patient/ClockGame/widget/clock_question.dart';
import 'package:alzpal_patient/ClockGame/widget/wrong_popup.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClockGame extends StatefulWidget {
  const ClockGame({super.key});

  @override
  State<ClockGame> createState() => _ClockGameState();
}

class _ClockGameState extends State<ClockGame> {
  var questionIndex = 0;
  String selectedOption = '';
  bool isCorrect = false;

  List shuffledQuestions= List.of(questions);

  dynamic showPopUp(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'CLOSE',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ))
            ],
            backgroundColor: DarkBlack,
            content: WrongPopup(
                imageUrl: shuffledQuestions[questionIndex].imageurl,
                answer: shuffledQuestions[questionIndex].answer),
          );
        },
      );

  void _selectedOption(String answer) {
    setState(() {
      selectedOption = answer;
      isCorrect = answer == shuffledQuestions[questionIndex].answer;
    });

    if (isCorrect) {
      HapticFeedback.lightImpact();
      Future.delayed(Duration(seconds: 1), () {
        if (shuffledQuestions.length - 1 == questionIndex) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        } else {
          setState(() {
            questionIndex++;
            selectedOption = '';
          });
        }
      });
    } else {
      HapticFeedback.heavyImpact();
      showPopUp(context).then((_) {
        setState(() {
          selectedOption = '';
        });
      });
    }
  }

  @override
  initState() {
    super.initState();
    shuffledQuestions.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = shuffledQuestions[questionIndex];
    List<String> choice = currentQuestion.shuffledAnswers;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClockQuestion(imageUrl: currentQuestion.imageurl),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            for (var i = 0; i < choice.length; i++)
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedOption == '') {
                        _selectedOption(choice[i]);
                      }
                    },
                    child: ClockOption(
                      optionText: choice[i],
                      isSelected: choice[i] == selectedOption,
                      isCorrect: isCorrect,
                    ),
                  ),
                  if (i < choice.length - 1)
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
