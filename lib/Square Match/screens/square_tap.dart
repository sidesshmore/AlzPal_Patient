import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:flutter/material.dart';

class SquareTap extends StatefulWidget {
  const SquareTap({super.key});

  @override
  State<SquareTap> createState() => _SquareTapState();
}

class _SquareTapState extends State<SquareTap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'Square Tap'),
    );
  }
}
