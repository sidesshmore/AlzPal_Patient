import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/FlashCards/data/animal_questions.dart';
import 'package:alzpal_patient/FlashCards/data/fruit_question.dart';
import 'package:alzpal_patient/FlashCards/data/vegetable_question.dart';
import 'package:alzpal_patient/FlashCards/widget/flashcard_option.dart';
import 'package:alzpal_patient/FlashCards/widget/flashcard_question.dart';
import 'package:alzpal_patient/FlashCards/widget/wrong_popup.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:haptic_feedback/haptic_feedback.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  String? _selectedCardSet = 'Animals';
  var questionArray = 0;
  var questionIndex = 0;
  List animalQuestion = List.of(animal_question);
  List fruitQuestion = List.of(fruit_question);
  List vegetableQuestion = List.of(vegetable_question);
  int animalLen = animal_question.length;
  int fruitLen = fruit_question.length;
  int vegetableLen = vegetable_question.length;
  List<String> _cardSets = ['Animals', 'Fruits', 'Vegetables'];
  String selectedOption = '';
  bool isCorrect = false;
  int totalQuestionsCorrect = 0;
  int totalQuestionsAttempted = 0;
  List<int> correctResponseTimes = [];
  List<int> incorrectResponseTimes = [];
  late DateTime questionStartTime;
  late DateTime sessionStartTime;
  final _myFlashCard = Hive.box('flash_card');
  final _userBox = Hive.box('user');
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    questionStartTime = DateTime.now();
    sessionStartTime = DateTime.now();
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

    await _myFlashCard.put(
      sessionStartTime.toString(),
      {
        'gameName': 'flashCard',
        'sessionDuration': sessionDuration.inSeconds,
        'accuracy': accuracy,
        'avgCorrectResponseTime': averageCorrectResponseTime,
        'avgIncorrectResponseTime': averageIncorrectResponseTime,
      },
    );

    String date = sessionStartTime.toIso8601String().split('T').first;
    String time = sessionStartTime.toIso8601String().split('T').last;

    // Store session data in Supabase
    final userId = _userBox.get('id');
    final userName = _userBox.get('name');
    final response = await supabase.from('GameMetrics').insert({
      'uuid': userId,
      'userName': userName,
      'gameName': 'flashCard',
      'sessionDuration': sessionDuration.inSeconds,
      'accuracy': accuracy,
      'avgCorrectResponseTime': averageCorrectResponseTime,
      'avgIncorrectResponseTime': averageIncorrectResponseTime,
      'date': date,
      'time': time,
    });

    if (response.error != null) {
      log('Error storing data in Supabase: ${response.error!.message}');
    } else {
      log('Data stored successfully in Supabase');
    }

    // Print stored values to check functionality
    printStoredValues();

    // Session duration log
    log('Session Duration: ${sessionDuration.inMinutes} minutes and ${sessionDuration.inSeconds % 60} seconds');
  }

  void printStoredValues() async {
    // Print each valid stored session
    for (var key in _myFlashCard.keys) {
      var value = _myFlashCard.get(key);
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final currentQuestion = questionArray == 0
        ? animalQuestion[questionIndex]
        : questionArray == 1
            ? fruitQuestion[questionIndex]
            : vegetableQuestion[questionIndex];
    List<String> choice = currentQuestion.shuffledAnswers;

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
                  imageUrl: currentQuestion.url,
                  answer: currentQuestion.answer),
            );
          },
        );

    void _selectedOption(String answer) {
      setState(() {
        DateTime currentTime = DateTime.now();
        int responseTime = currentTime.difference(questionStartTime).inSeconds;

        selectedOption = answer;
        isCorrect = answer == currentQuestion.answer;
        totalQuestionsAttempted++;

        if (isCorrect) {
          totalQuestionsCorrect++;
          correctResponseTimes.add(responseTime);
        } else {
          incorrectResponseTimes.add(responseTime);
        }

        // Calculate accuracy
        double accuracy =
            (totalQuestionsCorrect / totalQuestionsAttempted) * 100;
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
          if (questionArray == 0 && questionIndex == animalLen - 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
            );
          } else if (questionArray == 1 && questionIndex == fruitLen - 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }),
            );
          } else if (questionArray == 2 && questionIndex == vegetableLen - 1) {
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
              isCorrect = false;
              questionStartTime =
                  DateTime.now(); // Start time for the next question
            });
          }
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

    return Scaffold(
      appBar: MyAppBar(MyAppBarHeading: 'Flash Cards'),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xff262626),
                    value: _selectedCardSet,
                    items: _cardSets
                        .map((set) => DropdownMenuItem(
                              value: set,
                              child: Text(set,
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        questionArray = (value == 'Animals'
                            ? 0
                            : value == 'Fruits'
                                ? 1
                                : 2);
                        _selectedCardSet = value;
                        questionIndex = 0;
                        selectedOption = '';
                        isCorrect = false;
                        totalQuestionsCorrect = 0;
                        totalQuestionsAttempted = 0;
                        correctResponseTimes.clear();
                        incorrectResponseTimes.clear();
                        questionStartTime = DateTime.now();
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xff62CA73), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Choose Card Set',
                      labelStyle: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.05),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlashcardQuestion(
                  imageUrl: currentQuestion.url,
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
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
                    child: FlashcardOption(
                      optionText: choice[i],
                      isSelected: choice[i] == selectedOption,
                      isCorrect: selectedOption == choice[i] && isCorrect,
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
