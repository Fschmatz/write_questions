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

  Widget buttonChangeState() {
    String textButton =
        widget.question.state == 0 ? 'Answered' : 'Not Answered';

    return Center(
      child: Card(
        color: Theme.of(context).accentColor,
        margin: const EdgeInsets.fromLTRB(140, 0, 140, 0),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          title: Text(
            textButton,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          onTap: () {
            changeState();
            widget.refresh();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
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

  void bottomMenuShowItem() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 30),
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(children: <Widget>[
                          ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(16, 5, 5, 0),
                            title: Text("Question".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .headline1!
                                        .color)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              EditQuestion(
                                            question: widget.question,
                                          ),
                                          fullscreenDialog: true,
                                        )).then((value) => widget.refresh());
                                  },
                                  splashRadius: 26,
                                  icon: Icon(Icons.edit_outlined, size: 22),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    size: 22
                                  ),
                                  splashRadius: 26,
                                  onPressed: () {
                                    showAlertDialogOkDelete(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListTile(
                            title: Text(
                              widget.question.text,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buttonChangeState()
                        ])
                      ]),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Visibility(
              visible: widget.question.state == 0,
              child: Icon(
                Icons.help_outline_outlined,
                size: 30,
                color: Theme.of(context).accentTextTheme.headline1!.color,
              )),
          Visibility(
              visible: widget.question.state == 0,
              child: const SizedBox(width: 20,)),
          Flexible(
            child: Text(
              widget.question.text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      trailing: Visibility(
          visible: widget.question.state == 1,
          child: Icon(
            Icons.check,
            size: 30,
            color: Theme.of(context).accentTextTheme.headline1!.color,
          )),
      onTap: () {
        bottomMenuShowItem();
      },
    );
  }
}
