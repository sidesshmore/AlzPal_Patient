import 'dart:developer';
import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/SquareTap/data/colorData.dart';
import 'package:alzpal_patient/SquareTap/widgets/square_check.dart';
import 'package:alzpal_patient/SquareTap/widgets/square_container.dart';
import 'package:alzpal_patient/SquareTap/widgets/square_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SquareTap extends StatefulWidget {
  const SquareTap({super.key});

  @override
  State<SquareTap> createState() => _SquareTapState();
}

class _SquareTapState extends State<SquareTap> {
  var colorIndex = 0;
  bool isCorrect = false;
  bool isSelected = false;
  late DateTime sessionStartTime;
  late DateTime sessionEndTime;
  late DateTime questionStartTime;
  late DateTime questionEndTime;
  List<double> correctResponseTimes = [];
  List<double> incorrectResponseTimes = [];

  final _mySquareTap = Hive.box('square_tap');
  final _userBox = Hive.box('user');
  final supabase = Supabase.instance.client;

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

  void changeColor() {
    setState(() {
      currentColorIndex = (currentColorIndex + 1) % colors.length;
    });
  }

  @override
  void initState() {
    super.initState();
    sessionStartTime = DateTime.now(); // Record session start time
    shuffledColor.shuffle();
    questionStartTime = DateTime.now(); // Start time for the first question
  }

  @override
  void dispose() async {
    super.dispose();
    sessionEndTime = DateTime.now();
    Duration sessionDuration = sessionEndTime.difference(sessionStartTime);
    log('Session Duration: ${sessionDuration.inMinutes} minutes and ${sessionDuration.inSeconds % 60} seconds');

    // Calculate and log average response times
    double avgCorrectResponseTime =
        calculateAverageResponseTime(correctResponseTimes);
    double avgIncorrectResponseTime =
        calculateAverageResponseTime(incorrectResponseTimes);
    log('Average Time to Answer Correctly: ${avgCorrectResponseTime.toStringAsFixed(2)} seconds');
    log('Average Time to Answer Incorrectly: ${avgIncorrectResponseTime.toStringAsFixed(2)} seconds');

    // Store session data with DateTime as the key
    await _mySquareTap.put(
      sessionStartTime.toString(),
      {
        'sessionDuration': sessionDuration.inSeconds,
        'avgCorrectResponseTime': avgCorrectResponseTime,
        'avgIncorrectResponseTime': avgIncorrectResponseTime,
      },
    );

    // Store session data in Supabase
    final userId = _userBox.get('id');
    final userName = _userBox.get('name');
    final response = await supabase.from('GameMetrics').insert({
      'uuid': userId,
      'userName': userName,
      'gameName': 'squareTap',
      'sessionDuration': sessionDuration.inSeconds,
      'avgCorrectResponseTime': avgCorrectResponseTime,
      'avgIncorrectResponseTime': avgIncorrectResponseTime,
    });

    if (response.error != null) {
      log('Error storing data in Supabase: ${response.error!.message}');
    } else {
      log('Data stored successfully in Supabase');
    }

    // Remove invalid entries
    removeInvalidEntries();

    printStoredValues();
  }

  // Function to handle answering a question
  void answerQuestion(bool correct) {
    setState(() {
      questionEndTime = DateTime.now();
      double responseTime =
          questionEndTime.difference(questionStartTime).inMilliseconds / 1000.0;

      if (correct) {
        correctResponseTimes.add(responseTime);
      } else {
        incorrectResponseTimes.add(responseTime);
      }

      // Proceed to next question or finish game logic here
      if (correct) {
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
              questionStartTime =
                  DateTime.now(); // Start time for the next question
            });
          }
        });
      } else {
        HapticFeedback.heavyImpact();
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            isSelected = false;
            questionStartTime =
                DateTime.now(); // Start time for the next question
          });
        });
      }
    });
  }

  double calculateAverageResponseTime(List<double> responseTimes) {
    if (responseTimes.isEmpty) return 0.0;
    return responseTimes.reduce((a, b) => a + b) / responseTimes.length;
  }

  // Function to remove invalid entries
  void removeInvalidEntries() async {
    List<dynamic> keysToRemove = [];
    for (var key in _mySquareTap.keys) {
      var value = _mySquareTap.get(key);
      if (key is! String || value is! Map) {
        keysToRemove.add(key);
      }
    }
    for (var key in keysToRemove) {
      await _mySquareTap.delete(key);
    }
  }

  void printStoredValues() async {
    for (var key in _mySquareTap.keys) {
      var value = _mySquareTap.get(key);
      if (value is Map &&
          value.containsKey('sessionDuration') &&
          value.containsKey('avgCorrectResponseTime') &&
          value.containsKey('avgIncorrectResponseTime')) {
        log('DateTime: $key, Data: $value');
      }
    }
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
                  ),
                ),
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

                    answerQuestion(isCorrect);
                  },
                  child: SquareCheck(
                    optionText: 'CHECK',
                    isCorrect: isCorrect,
                    isSelected: isSelected,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
