import 'dart:async';
import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/configs/settingsPage.dart';
import 'package:write_questions/db/questionDao.dart';
import 'package:write_questions/pages/newQuestion.dart';
import 'package:write_questions/widgets/questionTile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  final dbQuestion = QuestionDao.instance;
  List<Map<String, dynamic>> questionsList = [];

  @override
  void initState() {
    getAll();
    super.initState();
  }

  Future<void> getAll() async {
    var resp = await dbQuestion.queryAllRowsDesc();
    setState(() {
      questionsList = resp;
    });
  }

  void refreshHome() {
    getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Write Questions',
        ),
      ),
      body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
        ListTile(
          trailing: Icon(
            Icons.help_outline_outlined,
            color: Theme.of(context).accentTextTheme.headline1!.color,
            size: 25,
          ),
          title: Text("Not Answered".toUpperCase(),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentTextTheme.headline1!.color)),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: questionsList.length,
            itemBuilder: (context, index) {
              if (questionsList[index]['state'] == 0) {
                return QuestionTile(
                    key: UniqueKey(),
                    refresh: getAll,
                    question: Question(
                        questionsList[index]['id'],
                        questionsList[index]['text'],
                        questionsList[index]['state']));
              } else {
                return SizedBox.shrink();
              }
            }),
        const Divider(),
        ListTile(
          trailing: Icon(
            Icons.check_circle_outline_outlined,
            color: Theme.of(context).accentColor,
            size: 25,
          ),
          title: Text("Answered".toUpperCase(),
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).accentColor)),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: questionsList.length,
            itemBuilder: (context, index) {
              if (questionsList[index]['state'] == 1) {
                return QuestionTile(
                    key: UniqueKey(),
                    refresh: getAll,
                    question: Question(
                        questionsList[index]['id'],
                        questionsList[index]['text'],
                        questionsList[index]['state']));
              } else {
                return SizedBox.shrink();
              }
            }),
        const SizedBox(
          height: 20,
        )
      ]),
      floatingActionButton: Container(
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NewQuestion(),
                    fullscreenDialog: true,
                  )).then((value) => getAll());
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
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
                      )).then((value) => getAll());
                }),
          ],
        ),
      )),
    );
  }
}
