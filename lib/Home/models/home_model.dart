import 'package:flutter/material.dart';

class HomeGame {
  final String imagePath;
  final String title;
  Widget nextScreen;

  HomeGame(
      {required this.imagePath, required this.title, required this.nextScreen});
}
