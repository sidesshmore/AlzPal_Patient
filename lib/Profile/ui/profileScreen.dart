import 'dart:developer';

import 'package:alzpal_patient/Profile/model/chartModel.dart';
import 'package:alzpal_patient/Profile/widgets/accuracyChart.dart';
import 'package:alzpal_patient/Profile/widgets/averageResponseChart.dart';
import 'package:alzpal_patient/Profile/widgets/sessionChart.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> _cardSets = ['Clock Game', 'Square Tap', 'FlashCard'];
  String? _selectedCardSet = 'Clock Game';
  final user = Hive.box('user');
  final _myClockGame = Hive.box('clock_game');
  final _mySquareTap = Hive.box('square_tap');
  final _myFlashCard = Hive.box('flash_card');

  List<AccuracyChartModel> ClockGameAccuracy = [];
  List<AverageResponseChartModel> ClockGameResponseTime = [];
  List<SessionchartModel> ClockGameSessionTime = [];

  List<AverageResponseChartModel> SquareTapResponseTime = [];
  List<SessionchartModel> SquareTapSessionTime = [];

  List<AccuracyChartModel> FlashCardAccuracy = [];
  List<AverageResponseChartModel> FlashCardResponseTime = [];
  List<SessionchartModel> FlashCardSessionTime = [];

  List<String> accuracy = ['ClockGameAccuracy', '', 'FlashCardAccuracy'];
  List<String> responseTime = [
    'ClockGameResponseTime',
    'SquareTapResponseTime',
    'FlashCardResponseTime'
  ];
  List<String> sessionTime = [
    'ClockGameSessionTime',
    'SquareTapSessionTime',
    'FlashCardSessionTime'
  ];

  var gameArray = 0;

  void initClockGameValues() async {
    int i = 0;
    for (var key in _myClockGame.keys) {
      var value = _myClockGame.get(key);
      if (value is Map &&
          value.containsKey('sessionDuration') &&
          value.containsKey('accuracy') &&
          value.containsKey('avgCorrectResponseTime') &&
          value.containsKey('avgIncorrectResponseTime')) {
        ClockGameAccuracy.add(AccuracyChartModel(
            i, value['accuracy'] is double ? value['accuracy'] : 0));
        ClockGameResponseTime.add(AverageResponseChartModel(
            i,
            value['avgCorrectResponseTime'],
            value['avgIncorrectResponseTime']));
        ClockGameSessionTime.add(SessionchartModel(
            i, double.parse(value['sessionDuration'].toString())));
        i++;
      }
    }
  }

  void initSquareTapGameValues() async {
    int i = 0;
    for (var key in _mySquareTap.keys) {
      var value = _mySquareTap.get(key);
      if (value is Map &&
          value.containsKey('sessionDuration') &&
          value.containsKey('avgCorrectResponseTime') &&
          value.containsKey('avgIncorrectResponseTime')) {
        SquareTapResponseTime.add(AverageResponseChartModel(
            i,
            value['avgCorrectResponseTime'],
            value['avgIncorrectResponseTime']));
        SquareTapSessionTime.add(SessionchartModel(
            i, double.parse(value['sessionDuration'].toString())));
        i++;
      }
    }
  }

  void initFlashCardGame() async {
    int i = 0;
    for (var key in _myFlashCard.keys) {
      var value = _myFlashCard.get(key);
      if (value is Map &&
          value.containsKey('sessionDuration') &&
          value.containsKey('accuracy') &&
          value.containsKey('avgCorrectResponseTime') &&
          value.containsKey('avgIncorrectResponseTime')) {
        FlashCardAccuracy.add(AccuracyChartModel(
            i, value['accuracy'] is double ? value['accuracy'] : 0));
        FlashCardResponseTime.add(AverageResponseChartModel(
            i,
            value['avgCorrectResponseTime'],
            value['avgIncorrectResponseTime']));
        FlashCardSessionTime.add(SessionchartModel(
            i, double.parse(value['sessionDuration'].toString())));
        i++;
      }
    }
  }

  @override
  void initState() {
    initClockGameValues();
    initFlashCardGame();
    initSquareTapGameValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    log(screenHeight.toString());
    log(screenWidth.toString());
    log(user.get('id'));
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Hi ',
                            style: TextStyle(color: Colors.white, fontSize: 41),
                            children: [
                          TextSpan(
                              text:
                                  '${user.get('name') != null ? user.get('name') : 'User'}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ]))
                  ],
                ),
              ),
              SizedBox(
                width: screenWidth * 0.6,
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
                      gameArray = (value == 'Clock Game'
                          ? 0
                          : value == 'Square Tap'
                              ? 1
                              : 2);
                    });
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff62CA73), width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.05),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              gameArray == 1
                  ? SizedBox()
                  : gameArray == 0
                      ? AccuracyChart(
                          chartData: ClockGameAccuracy,
                        )
                      : AccuracyChart(chartData: FlashCardAccuracy),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              gameArray == 0
                  ? AverageResponseChart(
                      chartData: ClockGameResponseTime,
                    )
                  : gameArray == 1
                      ? AverageResponseChart(
                          chartData: SquareTapResponseTime,
                        )
                      : AverageResponseChart(
                          chartData: FlashCardResponseTime,
                        ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              gameArray == 0
                  ? Sessionchart(
                      chartData: ClockGameSessionTime,
                    )
                  : gameArray == 1
                      ? Sessionchart(
                          chartData: SquareTapSessionTime,
                        )
                      : Sessionchart(
                          chartData: FlashCardSessionTime,
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
