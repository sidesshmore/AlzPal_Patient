// home_screen.dart
import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/CardMatch/screens/card_match.dart';
import 'package:alzpal_patient/ClockGame/screens/clock_game.dart';
import 'package:alzpal_patient/FlashCards/screens/flash_card.dart';
import 'package:alzpal_patient/Home/widgets/home_game_card.dart';
import 'package:alzpal_patient/SquareTap/screens/square_tap.dart';
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
    HomeGame(
        imagePath: 'assets/Clock.png',
        title: 'Clock\nGame',
        nextScreen: ClockGame()),
    // HomeGame(
    //     imagePath: 'assets/Card_Total.png',
    //     title: 'Card\nMatch',
    //     nextScreen: CardMatch()),
    HomeGame(
        imagePath: 'assets/Square.png',
        title: 'Square\nTap',
        nextScreen: SquareTap()),
    HomeGame(
        imagePath: 'assets/FlashCards.png',
        title: 'Flash\nCards',
        nextScreen: FlashCard()),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'GAMES'),
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
