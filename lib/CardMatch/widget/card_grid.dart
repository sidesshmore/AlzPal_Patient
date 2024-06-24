import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class CardGrid extends StatefulWidget {
  const CardGrid({super.key});

  @override
  State<CardGrid> createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: screenHeight * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: DarkBlack,
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: screenHeight * 0.027, crossAxisCount: 3),
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              height: screenHeight * 0.33,
              width: screenWidth * 0.21,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Card_Total.png'))),
            ),
          );
        },
        itemCount: 12,
      ),
    );
  }
}
