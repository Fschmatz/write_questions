import 'dart:async';
import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/db/questionDao.dart';
import 'package:write_questions/pages/newQuestion.dart';
import 'package:write_questions/widgets/questionTile.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();

  int state;

  ItemList({required Key key, required this.state}) : super(key: key);
}

class _ItemListState extends State<ItemList> {

  bool loading = true;
  final dbQuestion = QuestionDao.instance;
  List<Map<String, dynamic>> questionsList = [];

  @override
  void initState() {
    getAll();
    super.initState();
  }

  Future<void> getAll() async {
    var resp = await dbQuestion.getItemsState(widget.state);
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
      body: ListView(physics: AlwaysScrollableScrollPhysics(), children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: questionsList.length,
            itemBuilder: (context, index) {
              return QuestionTile(
                  key: UniqueKey(),
                  refresh: getAll,
                  index: index,
                  question: Question(
                      questionsList[index]['id'],
                      questionsList[index]['text'],
                      questionsList[index]['state']));
            }),
        const SizedBox(
          height: 100,
        )
      ]),
      floatingActionButton: Visibility(
        visible: widget.state == 0,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
