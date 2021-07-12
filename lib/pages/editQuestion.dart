import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/db/questionDao.dart';

class EditQuestion extends StatefulWidget {
  Question question;

  EditQuestion({Key? key, required this.question}) : super(key: key);

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  final dbQuestion = QuestionDao.instance;
  TextEditingController customControllerText = TextEditingController();

  @override
  void initState() {
    super.initState();
    customControllerText.text = widget.question.text;
  }


  void _updateDayNote() async {
    Map<String, dynamic> row = {
      QuestionDao.columnId: widget.question.id,
      QuestionDao.columnText: customControllerText.text,
    };
    final update = await dbQuestion.update(row);
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
      child: Text(
        "Ok",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Error",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Text(
        checkProblems(),
        style: TextStyle(
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
          title: Text("Edit Question"),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: IconButton(
                icon: Icon(Icons.save_outlined),
                tooltip: 'Save',
                onPressed: () {
                  if (checkProblems().isEmpty) {
                    _updateDayNote();
                    Navigator.of(context).pop();
                  } else {
                    showAlertDialogErrors(context);
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    minLines: 1,
                    maxLines: 12,
                    maxLength: 1000,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    controller: customControllerText,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.text_snippet_outlined,
                          size: 20,
                          color: Theme.of(context).textTheme.headline6!.color!),
                      hintText: "Question",
                      helperText: "* Required",
                    ),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ])));
  }
}
