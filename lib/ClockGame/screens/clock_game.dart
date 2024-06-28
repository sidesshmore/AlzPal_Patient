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

  

  var questionIndex=0;


  List shuffledQuestions=List.of(questions);  

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
            content: WrongPopup(imageUrl: shuffledQuestions[questionIndex].imageurl,answer: shuffledQuestions[questionIndex].answer),
          );
        },
      );


  void _selectedOption(String answer,BuildContext context){
    log('triggered');
    log(answer);
    if(questionIndex+1==questions.length){
      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
            );
    }
    if(answer==shuffledQuestions[questionIndex].answer){
      setState(() {
        questionIndex++;
      });
    }else{
      HapticFeedback.heavyImpact();
      showPopUp(context);
    }
  }

  @override
  initState() {
    shuffledQuestions.shuffle();
  }


  @override
  Widget build(BuildContext context) {

    final currentQuestion=shuffledQuestions[questionIndex];
    List<String> choice=currentQuestion.shuffledAnswers;

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
            InkWell(
              onTap: (){_selectedOption(choice[0],context);},
              child: ClockOption(
                optionText: choice[0],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            InkWell(
              onTap: () {
                _selectedOption(choice[1],context);
              },
              child: ClockOption(
                optionText: choice[1],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
