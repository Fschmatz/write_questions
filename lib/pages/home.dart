import 'package:flutter/material.dart';
import 'package:write_questions/configs/settings_page.dart';
import 'package:write_questions/db/question_dao.dart';
import 'package:write_questions/widgets/question_list.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final dbQuestion = QuestionDao.instance;
  List<Map<String, dynamic>> questionsList = [];

  int _currentIndex = 0;
  final List<Widget> _tabs = [
    QuestionList(
      key: UniqueKey(),
      state: 0,
    ),
    QuestionList(
      key: UniqueKey(),
      state: 1,
    )
  ];


  @override
  Widget build(BuildContext context) {

    TextStyle styleFontNavBar =
    TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Write Questions',
        ),
        actions: [IconButton(
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context)
                  .textTheme
                  .headline6!
                  .color!
                  .withOpacity(0.8),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => SettingsPage(),
                    fullscreenDialog: true,
                  ));
            }),],
      ),

      body: _tabs[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).accentColor.withOpacity(0.4),
              hoverColor: Theme.of(context).accentColor.withOpacity(0.4),
              color:
              Theme.of(context).textTheme.headline6!.color!.withOpacity(0.8),
              gap: 8,
              activeColor: Theme.of(context).accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              duration: const Duration(milliseconds: 500),
              tabBackgroundColor:
              Theme.of(context).accentColor.withOpacity(0.4),
              backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
              tabs: [
                GButton(
                  icon: Icons.help_outline_outlined,
                  text: 'Not Answered',
                  textStyle: styleFontNavBar,
                ),
                GButton(
                  icon: Icons.check_circle_outline_outlined,
                  text: 'Answered',
                  textStyle: styleFontNavBar,
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
