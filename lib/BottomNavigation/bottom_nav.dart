import 'package:alzpal_patient/Home/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final keyOne = GlobalKey();
  int _selectedIndex = 0;

  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  // void _openAddExpenseOverlay() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (ctx) => AddModal());
  // }

  static List pageNames = [
    'HomePage',
    // 'Analytics',
    // 'FlashCard',
    'ProfilePage'
  ];

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // CaregiverHome(),
    HomeScreen()
  ];

  void _onItemTapped(int index) async {
    // await analytics.logEvent(
    //     name: 'pages_tracked',
    //     parameters: {"page_name": pageNames[index], "page_index": index});

    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   analytics.setAnalyticsCollectionEnabled(true);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(

      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff171717),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(size: screenWidth * 0.09, CupertinoIcons.game_controller),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_solid, size: screenWidth * 0.09),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Color(0xff62CA73),
        unselectedItemColor: Color(0xffA3A3A3),
      ),
    );
  }
}
