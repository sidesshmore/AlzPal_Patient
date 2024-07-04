import 'package:alzpal_patient/AppBar/app_bar.dart';
import 'package:alzpal_patient/FlashCards/data/animal_questions.dart';
import 'package:alzpal_patient/FlashCards/data/fruit_question.dart';
import 'package:alzpal_patient/FlashCards/data/vegetable_question.dart';
import 'package:alzpal_patient/FlashCards/widget/flashcard_option.dart';
import 'package:alzpal_patient/FlashCards/widget/flashcard_question.dart';
import 'package:alzpal_patient/FlashCards/widget/wrong_popup.dart';
import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashCard extends StatefulWidget {
  const FlashCard({super.key});

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  String? _selectedCardSet = 'Animals';
  var questionArray = 0;
  var questionIndex = 0;
  List animalQuestion = List.of(animal_question);
  List fruitQuestion = List.of(fruit_question);
  List vegetableQuestion = List.of(vegetable_question);
  int animalLen = animal_question.length;
  int fruitLen = fruit_question.length;
  int vegetableLen = vegetable_question.length;
  List<String> _cardSets = ['Animals', 'Fruits', 'Vegetables'];
  String selectedOption = '';
  bool isCorrect = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final currentQuestion = questionArray == 0
        ? animalQuestion[questionIndex]
        : questionArray == 1
            ? fruitQuestion[questionIndex]
            : vegetableQuestion[questionIndex];
    List<String> choice = currentQuestion.shuffledAnswers;

    dynamic showPopUp(BuildContext context) => showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'CLOSE',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ))
              ],
              backgroundColor: DarkBlack,
              content: WrongPopup(
                  imageUrl: currentQuestion.url,
                  answer: currentQuestion.answer),
            );
          },
        );

    void _selectedOption(String answer) {
      setState(() {
        selectedOption = answer;
        isCorrect = answer == currentQuestion.answer;
      });

      if (isCorrect) {
        HapticFeedback.lightImpact();

        if (questionArray == 0 && questionIndex == animalLen - 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        } else if (questionArray == 1 && questionIndex == fruitLen - 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        } else if (questionArray == 2 && questionIndex == vegetableLen - 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }),
          );
        } else {
          setState(() {
            questionIndex++;
            selectedOption = '';
            isCorrect = false;
          });
        }
      } else {
        HapticFeedback.heavyImpact();
        showPopUp(context).then((_) {
          setState(() {
            selectedOption = '';
          });
        });
      }
    }

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
                        .map((set) => DropdownMenuItem(
                              value: set,
                              child: Text(set,
                                  style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        questionArray = (value == 'Animals'
                            ? 0
                            : value == 'Fruits'
                                ? 1
                                : 2);
                        _selectedCardSet = value;
                        questionIndex = 0;
                        selectedOption = '';
                        isCorrect = false;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlashcardQuestion(
                  imageUrl: currentQuestion.url,
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            for (var i = 0; i < choice.length; i++)
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedOption == '') {
                        _selectedOption(choice[i]);
                      }
                    },
                    child: FlashcardOption(
                      optionText: choice[i],
                      isSelected: choice[i] == selectedOption,
                      isCorrect: selectedOption == choice[i] && isCorrect,
                    ),
                  ),
                  if (i < choice.length - 1)
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
