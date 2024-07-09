import 'package:alzpal_patient/OnBoarding/ui/NameScreen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.031,
        backgroundColor: const Color(0xff262626),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/Onboarding-1.png',
            height: screenHeight * 0.55,
            width: screenWidth,
          ),
          SizedBox(
            height: screenHeight * 0.080,
          ),
          RichText(
            text: TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
                    fontSize: screenWidth * 0.074,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                children: [
                  TextSpan(
                    text: 'AlzPal',
                    style: TextStyle(
                      fontSize: screenWidth * 0.074,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff62CA73),
                    ),
                  )
                ]),
          ),
          SizedBox(
            height: screenHeight * 0.005,
          ),
          SizedBox(
            width: screenWidth * 0.688,
            child: Text(
              "Your friendly companion in Alzheimer's care.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.048,
                fontWeight: FontWeight.w600,
                color: const Color(0xffA3A3A3),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.024,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder:(context)=> const NameScreen()));
            },
            color: const Color(0xff62CA73),
            textColor: Colors.white,
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
            child: Icon(
              Icons.arrow_forward,
              size: screenWidth * 0.1,
            ),
          )
        ],
      ),
    );
  }
}