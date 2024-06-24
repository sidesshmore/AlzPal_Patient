import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/FlashCards/widget/flashcard_option.dart';
import 'package:alzpal_patient/FlashCards/widget/flashcard_question.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  String? _selectedCardSet;
  List<String> _cardSets = ['Animals', 'Fruits', 'Vegetables'];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(MyAppBarHeading: 'Flash Cards'),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  child: DropdownButtonFormField<String>(
                    dropdownColor: const Color(0xff262626),
                    value: _selectedCardSet,
                    items: _cardSets
                        .map((patient) => DropdownMenuItem(
                              value: patient,
                              child: Text(patient,
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCardSet = value;
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xff62CA73), width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Choose Card Set',
                      labelStyle: TextStyle(
                          color: Colors.white, fontSize: screenWidth * 0.05),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [FlashcardQuestion()],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            FlashcardOption(optionText: 'MANGO'),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            FlashcardOption(optionText: 'TOMATO'),
          ],
        ),
      ),
    );
  }
}
