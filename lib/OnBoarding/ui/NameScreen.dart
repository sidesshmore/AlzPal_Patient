import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:alzpal_patient/colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _namecontroller = TextEditingController();
  final user = Hive.box('user');
  final supabase = Supabase.instance.client;
  final uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.045),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'What\'s your name?',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.08),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.011,
              ),
              Row(
                children: [
                  Text(
                    'We\'re so glad you\'re here!\nHow would you like us to call you?',
                    style: TextStyle(
                        color: Colors.white, fontSize: screenWidth * 0.05),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.11,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                controller: _namecontroller,
                style: TextStyle(
                    color: Colors.white, fontSize: screenWidth * 0.08),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: GreenColor))),
              ),
              SizedBox(
                height: screenHeight * 0.20,
              ),
              InkWell(
                onTap: () async {
                  final userName = _namecontroller.text;
                  final userId = uuid.v4();

                  // Save to Hive
                  await user.put('name', userName);
                  await user.put('id', userId);

                  // Save to Supabase
                  final response = await supabase
                      .from('UserTable')
                      .insert({'id': userId, 'name': userName});

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                },
                child: Container(
                  width: screenWidth * 0.71,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: GreenColor,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Next',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
