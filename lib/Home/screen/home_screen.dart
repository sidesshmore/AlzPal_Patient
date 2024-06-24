// home_screen.dart
import 'package:alzpal_patient/Home/widgets/home_game_card.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:alzpal_patient/Home/models/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<HomeGame> games = [
    HomeGame(imagePath: 'assets/Clock.png', title: 'Clock\nGame'),
    HomeGame(imagePath: 'assets/Card_Total.png', title: 'Card\nMatch'),
    HomeGame(imagePath: 'assets/Square.png', title: 'Square\nTap'),
    HomeGame(imagePath: 'assets/FlashCards.png', title: 'Flash\nCards'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GAMES',
          style: TextStyle(
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.w700,
              color: GreenColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Icon(
              Icons.sunny,
              size: screenWidth * 0.083,
              color: GreenColor,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
            child: HomeGameCard(game: games[index]),
          );
        },
      ),
    );
  }
}
