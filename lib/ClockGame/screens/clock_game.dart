import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:flutter/material.dart';

class ClockGame extends StatefulWidget {
  const ClockGame({super.key});

  @override
  State<ClockGame> createState() => _ClockGameState();
}

class _ClockGameState extends State<ClockGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'Clock Game'),
    );
  }
}
