import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:write_questions/db/question_dao.dart';

class NewQuestion extends StatefulWidget {
  const NewQuestion({Key? key}) : super(key: key);

  @override
  _NewQuestionState createState() => _NewQuestionState();
}

class _NewQuestionState extends State<NewQuestion> {
  final dbQuestion = QuestionDao.instance;
  TextEditingController customControllerText = TextEditingController();
  TextEditingController customControllerNote = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _saveQuestion() async {
    Map<String, dynamic> row = {
      QuestionDao.columnText: customControllerText.text,
      QuestionDao.columnState: 0,
      QuestionDao.columnNote: customControllerNote.text,
    };
    final id = await dbQuestion.insert(row);
  }

  String checkProblems() {
    String errors = "";
    if (customControllerText.text.isEmpty) {
      errors += "Text is empty\n";
    }
    return errors;
  }

  showAlertDialogErrors(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: const Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Question"),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: const Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkProblems().isEmpty) {
                    _saveQuestion();
                    Navigator.of(context).pop();
                  } else {
                    showAlertDialogErrors(context);
                  }
                },
              ),
            ),
          ],
        ),
        body: ListView(children: [
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Question".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentTextTheme.headline1!.color)),
          ),
          ListTile(
            leading: const Icon(Icons.notes_outlined),
            title: TextField(
              autofocus: true,
              minLines: 1,
              maxLines: 5,
              maxLength: 200,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: customControllerText,
              decoration: InputDecoration(
                focusColor: Theme.of(context).accentColor,
                helperText: "* Required",
              ),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ListTile(
            leading: const SizedBox(
              height: 0.1,
            ),
            title: Text("Note".toUpperCase(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentTextTheme.headline1!.color)),
          ),
          ListTile(
            leading: const Icon(Icons.article_outlined),
            title: TextField(
              minLines: 1,
              maxLines: 5,
              maxLength: 1000,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: customControllerNote,
              decoration:
                  InputDecoration(focusColor: Theme.of(context).accentColor),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ]));
  }
}
