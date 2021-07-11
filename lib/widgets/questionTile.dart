import 'package:flutter/material.dart';
import 'package:write_questions/classes/question.dart';
import 'package:write_questions/db/questionDao.dart';

class QuestionTile extends StatefulWidget {
  @override
  _QuestionTileState createState() => _QuestionTileState();

  Question question;
  //Function() refresh;

  QuestionTile(
      {required Key key, required this.question})
      : super(key: key);
}

class _QuestionTileState extends State<QuestionTile> {

  void changeBugState(int id, int state) async {
    final dbQuestion = QuestionDao.instance;
    Map<String, dynamic> row = {
      QuestionDao.columnId: id,
      QuestionDao.columnState: state,
    };
    final update = await dbQuestion.update(row);
  }

  void bottomMenuShowItem() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              radius: 15,
                            ),
                            title: Text(
                              widget.question.text,
                              style: TextStyle(
                                  fontSize: 16.5, fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                /*Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EditBug(bug: widget.bug),
                                      fullscreenDialog: true,
                                    )).then((value) => widget.refreshHome());*/
                              },
                              icon: Icon(Icons.edit_outlined, size: 22),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: ListTile(
                              leading: Icon(Icons.article_outlined, size: 22),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Application Name",
                                    style: TextStyle(fontSize: 14,color: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .color!
                                        .withOpacity(0.7),),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.question.text,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Card(
                              color: Theme.of(context).accentColor,
                              margin: const EdgeInsets.fromLTRB(140, 0, 140, 0),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                title:  Text(
                                  "Close",textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                onTap: () {
                                  //Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
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
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          widget.question.text,
          style: TextStyle(fontSize: 16),
        ),
      ),
      leading: CircleAvatar(),
      onTap: () {
        bottomMenuShowItem();
      },
    );
  }
}
