import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class SquareContainer extends StatefulWidget {
   SquareContainer({super.key,required this.color});
    Color color;

  @override
  State<SquareContainer> createState() => _SquareContainerState();
}

class _SquareContainerState extends State<SquareContainer> {
 

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
        height: screenHeight * 0.23,
        width: screenWidth * 0.50,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
        ),
      );
    
  }
}
