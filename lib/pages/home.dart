import 'package:flutter/material.dart';
import 'package:write_questions/configs/settings_page.dart';
import 'package:write_questions/db/question_dao.dart';
import 'package:write_questions/widgets/question_list.dart';

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

    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.help_outline_outlined),
            selectedIcon: Icon(
              Icons.help,
              color: Colors.black87,
            ),
            label: 'Not Answered',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline_outlined),
            selectedIcon: Icon(
              Icons.check_circle,
              color: Colors.black87,
            ),
            label: 'Answered',
          ),
        ],
      )
    );
  }
}
