import 'package:flutter/material.dart';

import 'package:write_questions/configs/settingsPage.dart';
import 'package:write_questions/widgets/itemList.dart';
import 'package:flutter_tab_indicator_styler/flutter_tab_indicator_styler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextStyle tabBarStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 15);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            'Write Questions',
          ),
          actions: [
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
                      ));
                }),
          ],
          bottom: TabBar(
            indicatorWeight: 0,
            labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            labelStyle: tabBarStyle,
            tabs: [
              Tab(text: 'Searching'.toUpperCase()),
              Tab(text: 'Answered'.toUpperCase()),
            ],
            indicator: MaterialIndicator(
                height: 4,
                color: Theme.of(context).accentColor,
                paintingStyle: PaintingStyle.fill,
                horizontalPadding: 50),
          ),
        ),
        body: TabBarView(
          children: [
            ItemList(
              key: UniqueKey(),
              state: 0,
            ),
            ItemList(
              key: UniqueKey(),
              state: 1,
            ),
          ],
        ),
      ),
    );
  }
}
