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
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ClockGame extends StatefulWidget {
  const ClockGame({super.key});

  @override
  State<ClockGame> createState() => _ClockGameState();
}

class _ClockGameState extends State<ClockGame> {
  var questionIndex = 0;
  String selectedOption = '';
  bool isCorrect = false;
  int totalQuestionsAttempted = 0;
  int totalQuestionsCorrect = 0;

  List<double> correctResponseTimes = [];
  List<double> incorrectResponseTimes = [];
  late DateTime questionStartTime;
  late DateTime sessionStartTime;

  List shuffledQuestions = List.of(questions);
  final _myClockGame = Hive.box('clock_game');
  final _userBox = Hive.box('user');
  final supabase = Supabase.instance.client;

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
      DateTime questionEndTime = DateTime.now();
      double responseTime =
          questionEndTime.difference(questionStartTime).inMilliseconds / 1000.0;

      selectedOption = answer;
      isCorrect = answer == shuffledQuestions[questionIndex].answer;
      totalQuestionsAttempted++;

      if (isCorrect) {
        totalQuestionsCorrect++;
        correctResponseTimes.add(responseTime);
      } else {
        incorrectResponseTimes.add(responseTime);
      }

      // Calculate accuracy
      double accuracy = (totalQuestionsCorrect / totalQuestionsAttempted) * 100;
      log('Current Accuracy: ${accuracy.toStringAsFixed(2)}%');

      // Calculate average response times
      double averageCorrectResponseTime = correctResponseTimes.isNotEmpty
          ? correctResponseTimes.reduce((a, b) => a + b) /
              correctResponseTimes.length
          : 0.0;

      double averageIncorrectResponseTime = incorrectResponseTimes.isNotEmpty
          ? incorrectResponseTimes.reduce((a, b) => a + b) /
              incorrectResponseTimes.length
          : 0.0;

      log('Average Correct Response Time: ${averageCorrectResponseTime.toStringAsFixed(2)} seconds');
      log('Average Incorrect Response Time: ${averageIncorrectResponseTime.toStringAsFixed(2)} seconds');

      if (isCorrect) {
        HapticFeedback.lightImpact();
        Haptics.vibrate(HapticsType.success);
        Haptics.vibrate(HapticsType.medium);
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
              questionStartTime =
                  DateTime.now(); // Start time for the next question
            });
          }
        });
      } else {
        HapticFeedback.heavyImpact();
        Haptics.vibrate(HapticsType.error);
        Haptics.vibrate(HapticsType.heavy);
        showPopUp(context).then((_) {
          setState(() {
            selectedOption = '';
            questionStartTime =
                DateTime.now(); // Start time for the next question
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    shuffledQuestions.shuffle();
    questionStartTime = DateTime.now(); // Initial start time
    sessionStartTime = DateTime.now(); // Record session start time
  }

  @override
  void dispose() async {
    super.dispose();
    DateTime sessionEndTime = DateTime.now();
    Duration sessionDuration = sessionEndTime.difference(sessionStartTime);

    // Calculate accuracy
    double accuracy = (totalQuestionsCorrect / totalQuestionsAttempted) * 100;

    // Calculate average response times
    double averageCorrectResponseTime = correctResponseTimes.isNotEmpty
        ? correctResponseTimes.reduce((a, b) => a + b) /
            correctResponseTimes.length
        : 0.0;

    double averageIncorrectResponseTime = incorrectResponseTimes.isNotEmpty
        ? incorrectResponseTimes.reduce((a, b) => a + b) /
            incorrectResponseTimes.length
        : 0.0;

    // Store session data with DateTime as the key in Hive
    await _myClockGame.put(
      sessionStartTime.toString(),
      {
        'gameName': 'clockGame',
        'sessionDuration': sessionDuration.inSeconds,
        'accuracy': accuracy,
        'avgCorrectResponseTime': averageCorrectResponseTime,
        'avgIncorrectResponseTime': averageIncorrectResponseTime,
      },
    );

    // Store session data in Supabase
    final userId = _userBox.get('id');
    final userName = _userBox.get('name');

    final response = await supabase.from('GameMetrics').insert({
      'uuid': userId,
      'userName': userName,
      'gameName': 'clockGame',
      'sessionDuration': sessionDuration.inSeconds,
      'accuracy': accuracy,
      'avgCorrectResponseTime': averageCorrectResponseTime,
      'avgIncorrectResponseTime': averageIncorrectResponseTime,
    });

    if (response.error != null) {
      log('Error storing data in Supabase: ${response.error!.message}');
    } else {
      log('Data stored successfully in Supabase');
    }

    printStoredValues();

    // Session duration log
    log('Session Duration: ${sessionDuration.inMinutes} minutes and ${sessionDuration.inSeconds % 60} seconds');
  }

  // Function to print stored values
  void printStoredValues() async {
    for (var key in _myClockGame.keys) {
      var value = _myClockGame.get(key);
      if (value is Map &&
          value.containsKey('sessionDuration') &&
          value.containsKey('accuracy') &&
          value.containsKey('avgCorrectResponseTime') &&
          value.containsKey('avgIncorrectResponseTime')) {
        print('DateTime: $key, Data: $value');
      }
    }
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
