import 'dart:async';
import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/db/question_dao.dart';
import 'package:write_questions/pages/new_question.dart';
import 'package:write_questions/widgets/question_tile.dart';

class QuestionList extends StatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();

  int state;

  QuestionList({required Key key, required this.state}) : super(key: key);
}

class _QuestionListState extends State<QuestionList> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
        ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            physics: const NeverScrollableScrollPhysics(),
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
                      questionsList[index]['state'],
                      questionsList[index]['note']));
            }),
        const SizedBox(
          height: 100,
        )
      ]),
      floatingActionButton: Visibility(
        visible: widget.state == 0,
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          elevation: 0.0,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const NewQuestion(),
                  fullscreenDialog: true,
                )).then((value) => getAll());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
