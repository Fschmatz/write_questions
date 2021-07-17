import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/db/questionDao.dart';
import 'package:write_questions/pages/editQuestion.dart';

class QuestionTile extends StatefulWidget {
  @override
  _QuestionTileState createState() => _QuestionTileState();

  Question question;
  Function() refresh;

  QuestionTile(
      {required Key key, required this.question, required this.refresh})
      : super(key: key);
}

class _QuestionTileState extends State<QuestionTile> {
  void changeState() async {
    final dbQuestion = QuestionDao.instance;
    Map<String, dynamic> row = {
      QuestionDao.columnId: widget.question.id,
      QuestionDao.columnState: widget.question.state == 0 ? 1 : 0,
    };
    final update = await dbQuestion.update(row);
  }

  showAlertDialogOkDelete(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor),
      ),
      onPressed: () {
        _delete();
        widget.refresh();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      elevation: 3.0,
      title: Text(
        "Confirm", //
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: Text(
        "\nDelete ?",
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

  Future<void> _delete() async {
    final dbQuestion = QuestionDao.instance;
    final deleted = await dbQuestion.delete(widget.question.id);
  }

  void openBottomMenu() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    leading: widget.question.state == 0
                        ? Icon(Icons.check_circle_outline_outlined,
                            color: Theme.of(context).hintColor,size: 25,)
                        : Icon(Icons.help_outline_outlined,
                            color: Theme.of(context).hintColor,size: 25,),
                    title: Text(
                      widget.question.state == 1
                          ? 'Mark question as not answered'
                          : 'Mark question as answered',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      changeState();
                      widget.refresh();
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.edit_outlined,
                        color: Theme.of(context).hintColor),
                    title: Text(
                      "Edit question",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => EditQuestion(
                              question: widget.question,
                            ),
                            fullscreenDialog: true,
                          )).then((value) => widget.refresh());
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.delete_outline_outlined,
                        color: Theme.of(context).hintColor),
                    //trailing: Icon(Icons.keyboard_arrow_right),
                    title: Text(
                      "Delete question",
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      showAlertDialogOkDelete(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading: SizedBox.shrink(),

      title: Text(
        widget.question.text,
        style: TextStyle(fontSize: 16),
      ),
      onTap: () {
        openBottomMenu();
      },
    );
  }
}
