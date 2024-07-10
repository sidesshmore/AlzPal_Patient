import 'dart:developer';

import 'package:alzpal_patient/BottomNavigation/bottom_nav.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/OnBoarding/ui/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'colors.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Supabase.initialize(
    url: 'https://vvcsklvghuwnldwgmine.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2Y3NrbHZnaHV3bmxkd2dtaW5lIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjA1NDM4NDQsImV4cCI6MjAzNjExOTg0NH0.cL0NpYDn21cH-YdDR6VPLNMsot4LRBKZX79qZvRryCE',
  );

  var box1 = await Hive.openBox('square_tap');
  var box2 = await Hive.openBox('clock_game');
  var box3 = await Hive.openBox('flash_card');
  var box4 = await Hive.openBox('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Hive.box('user');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LATEST VERSION - 9/7/24',
      theme: ThemeData(
          scaffoldBackgroundColor: MainBackgroundColor,
          appBarTheme: const AppBarTheme(backgroundColor: MainBackgroundColor)),
      home: user.get('name') == null ? OnboardingScreen() : HomeScreen(),
    );
  }
}
