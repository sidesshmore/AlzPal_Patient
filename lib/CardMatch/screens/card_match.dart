import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:flutter/material.dart';

class CardMatch extends StatefulWidget {
  const CardMatch({super.key});

  @override
  State<CardMatch> createState() => _CardMatchState();
}

class _CardMatchState extends State<CardMatch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(MyAppBarHeading: 'Card Match'),
    );
  }
}
