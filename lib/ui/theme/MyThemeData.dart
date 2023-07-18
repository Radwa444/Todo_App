import 'package:flutter/material.dart';

class MyThemeData {
  static const Color prmaryColorOfLigthTheme = Colors.blue;
  static var LigthTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey,
      appBarTheme: const AppBarTheme(
          color: prmaryColorOfLigthTheme,
          titleTextStyle: TextStyle(fontSize: 25, color: Colors.white)),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: prmaryColorOfLigthTheme));
}
