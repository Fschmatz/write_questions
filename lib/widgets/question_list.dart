import 'dart:async';
import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/configs/settings_page.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Write Questions'),
              pinned: false,
              floating: true,
              snap: true,
              actions: [
                IconButton(
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                            SettingsPage(),
                            fullscreenDialog: true,
                          ));
                    }),
              ],
            ),
          ];
        },
        body: ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
          ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 0,),
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
      ),
      floatingActionButton:  widget.state == 0 ? FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
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
          color: Colors.black87,
        ),
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
