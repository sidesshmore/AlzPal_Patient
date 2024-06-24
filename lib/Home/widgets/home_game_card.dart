// home_game_card.dart
import 'package:alzpal_patient/ClockGame/screens/clock_game.dart';
import 'package:flutter/material.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:alzpal_patient/Home/models/home_model.dart';

class HomeGameCard extends StatelessWidget {
  final HomeGame game;

  const HomeGameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ClockGame()));
          },
          child: Container(
            height: screenHeight * 0.181,
            width: screenWidth * 0.9465,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(33),
              color: DarkBlack,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    game.imagePath,
                    width: screenWidth * 0.346,
                    height: screenHeight * 0.159,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
