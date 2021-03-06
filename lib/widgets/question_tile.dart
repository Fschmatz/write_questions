import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/db/question_dao.dart';
import 'package:write_questions/pages/edit_question.dart';
import 'package:linkwell/linkwell.dart';

class QuestionTile extends StatefulWidget {
  @override
  _QuestionTileState createState() => _QuestionTileState();

  Question question;
  Function() refresh;
  int index;

  QuestionTile(
      {required Key key,
      required this.question,
      required this.index,
      required this.refresh})
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      title: const Text(
        "Confirm", //
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      content: const Text(
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
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: widget.question.state == 0
                      ? const Icon(
                          Icons.check_circle_outline_outlined,
                          size: 25,
                        )
                      : const Icon(
                          Icons.help_outline_outlined,
                          size: 25,
                        ),
                  title: Text(
                    widget.question.state == 1
                        ? 'Mark as not answered'
                        : 'Mark as answered',
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    changeState();
                    widget.refresh();
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: const Text(
                    "Edit",
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
                  leading: const Icon(Icons.delete_outline_outlined),
                  title: const Text(
                    "Delete",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    showAlertDialogOkDelete(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 4, 16,4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () {
          openBottomMenu();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              title: Text(
                widget.question.text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.headline6!.color),
              ),
            ),
            Visibility(
              visible: widget.question.note.isNotEmpty,
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                title: LinkWell(
                  widget.question.note+"\n",
                  linkStyle: TextStyle(
                    color: Theme.of(context)
                        .accentTextTheme
                        .headline1!
                        .color!
                        .withOpacity(0.8),
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                  ),
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context)
                          .textTheme
                          .headline6!
                          .color!
                          .withOpacity(0.9)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
