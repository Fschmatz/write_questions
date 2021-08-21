import 'package:flutter/material.dart';
import 'package:write_questions/configs/settingsPage.dart';
import 'package:write_questions/db/questionDao.dart';
import 'package:write_questions/widgets/itemList.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  final dbQuestion = QuestionDao.instance;
  List<Map<String, dynamic>> questionsList = [];

  int _currentIndex = 0;
  List<Widget> _tabs = [
    ItemList(
      key: UniqueKey(),
      state: 0,
    ),
    ItemList(
      key: UniqueKey(),
      state: 1,
    ),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {

    TextStyle styleFontNavBar =
    TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Write Questions',
        ),
      ),
      body: _tabs[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Theme.of(context).accentColor.withOpacity(0.4),
              hoverColor: Theme.of(context).accentColor.withOpacity(0.4),
              color:
              Theme.of(context).textTheme.headline6!.color!.withOpacity(0.7),
              gap: 8,
              activeColor: Theme.of(context).accentColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              duration: Duration(milliseconds: 500),
              tabBackgroundColor:
              Theme.of(context).accentColor.withOpacity(0.3),
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
                GButton(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
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
