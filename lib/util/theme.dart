import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//CLARO
ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFFFFFFFF),
  accentColor: Colors.teal,
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  cardTheme: CardTheme(
    color: Color(0xFFF8F8F8),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFFF9F9F9),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.deepPurple),
    selectedLabelStyle: TextStyle(color: Colors.deepPurple),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFFE5E5E5),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor:  Color(0xFFFFFFFF),
  ),
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
          vertical: 15.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.teal,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15.0)),
      border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(15.0))
  ),
  accentTextTheme: TextTheme(
    headline1: TextStyle(color: Colors.teal),
    headline2: TextStyle(color: Color(0xFFF1F1F1)),
  ),
  bottomAppBarColor: Color(0xFFE4E4E4),
);

//ESCURO
ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF1E1E20),
    accentColor: Color(0xFF62A996),
    scaffoldBackgroundColor: Color(0xFF1E1E20),
    cardTheme: CardTheme(
      color: Color(0xFF1A1A1C),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Color(0xFF303032),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor:  Color(0xFF1E1E20),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFFA590D5)),
      selectedLabelStyle: TextStyle(color: Color(0xFFA590D5)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF141416),
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF479C84),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(15.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(15.0))
    ),
    bottomAppBarColor: Color(0xFF141416),
    accentTextTheme: TextTheme(
      headline1: TextStyle(color: Color(0xFF9DECD6)),//0xFF88dbc4
      headline2: TextStyle(color: Color(0xFF000000)),
    )
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'valorTema';
  late SharedPreferences prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs.getBool(key) ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    prefs.setBool(key, _darkTheme);
  }
}

