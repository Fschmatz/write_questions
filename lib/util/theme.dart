import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


ThemeData light = ThemeData(
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.dark,
  primaryColor: const Color(0xFFFFFFFF),
  appBarTheme: const AppBarTheme(
      color: Color(0xFFFFFFFF),
      elevation: 0,
      iconTheme: IconThemeData(
          color: Color(0xFF050505)
      ),
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF000000))),
  accentColor: Colors.teal.shade400,
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  cardTheme: const CardTheme(
    color: Color(0xFFF0F5F4),
    elevation: 0
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFFF9F9F9),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(color: Colors.deepPurple),
    selectedLabelStyle: TextStyle(color: Colors.deepPurple),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFFE0E3E3),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor:  Color(0xFFFFFFFF),
  ),
  inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0, horizontal: 10.0),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.teal,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12.0)),
      border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12.0))
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.teal.shade400,
  ),
  accentTextTheme: const TextTheme(
    headline1: TextStyle(color: Colors.teal),
    headline2: TextStyle(color: Color(0xFFF1F1F1)),
  ),
  navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFFE0E3E3),
      indicatorColor: Colors.teal.shade400,
      iconTheme: MaterialStateProperty.all(const IconThemeData(
        color: Color(0xFF050505),
      )),
      labelTextStyle: MaterialStateProperty.all(const TextStyle(
          color: Color(0xFF050505), fontWeight: FontWeight.w500))),
  bottomAppBarColor: const Color(0xFFE0E3E3),
);


ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColorBrightness: Brightness.light,
    appBarTheme: const AppBarTheme(
        color: Color(0xFF202022),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFF5F5F5)),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFFFFFFFF))),
    primaryColor: const Color(0xFF202022),
    accentColor: const Color(0xFF56b097),
    scaffoldBackgroundColor: const Color(0xFF202022),
    cardTheme: const CardTheme(
      color: Color(0xFF2A2D2F),
      elevation: 0
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF303032),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor:  Color(0xFF202022),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFF8eedd3)),
      selectedLabelStyle: TextStyle(color: Color(0xFF8eedd3)),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF151517),
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF479C84),
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12.0)),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(12.0))
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF56b097),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF151617),
        indicatorColor: const Color(0xFF56b097),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFEAEAEA),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEAEAEA), fontWeight: FontWeight.w500))),
    bottomAppBarColor: const Color(0xFF29292B),
    accentTextTheme: const TextTheme(
      headline1: TextStyle(color: Color(0xFF8eedd3)),
      headline2: TextStyle(color: Color(0xFF000000))
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

