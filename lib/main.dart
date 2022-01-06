import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_questions/util/theme.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => ThemeNotifier(),

    child: Consumer<ThemeNotifier>(
      builder:(context, ThemeNotifier notifier, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: notifier.darkTheme ? dark : light,
          home: const App(),
        );
      },
    ),
  )
  );
}


