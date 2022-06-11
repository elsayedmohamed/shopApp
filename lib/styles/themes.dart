import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constant.dart';

ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedItemColor: Colors.grey,
    selectedItemColor: Colors.blue,
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('ffffff'),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.blueAccent),
    actionsIconTheme: IconThemeData(color: Colors.black),
    elevation: 0.0,
    backgroundColor: HexColor('ffffff'),
  ),
);
ThemeData darkTheme = ThemeData(primarySwatch: Colors.grey);
