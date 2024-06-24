import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class SquareContainer extends StatefulWidget {
  const SquareContainer({super.key});

  @override
  State<SquareContainer> createState() => _SquareContainerState();
}

class _SquareContainerState extends State<SquareContainer> {
  List<Color> colors = [
    GreenColor,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.red
  ];
  int currentColorIndex = 0;

  // Function to change the color
  void changeColor() {
    setState(() {
      currentColorIndex = (currentColorIndex + 1) % colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: changeColor,
      child: Container(
        height: screenHeight * 0.23,
        width: screenWidth * 0.50,
        decoration: BoxDecoration(
          color: colors[currentColorIndex],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
