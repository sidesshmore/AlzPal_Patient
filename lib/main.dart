import 'package:alzpal_patient/BottomNavigation/bottom_nav.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'colors.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();

  var box = await Hive.openBox('square_tap');
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
