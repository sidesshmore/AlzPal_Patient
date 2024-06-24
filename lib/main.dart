import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: MainBackgroundColor,
          appBarTheme: const AppBarTheme(backgroundColor: MainBackgroundColor)),
      home: HomeScreen(),
    );
  }
}
