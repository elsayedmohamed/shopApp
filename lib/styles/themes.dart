import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constant.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('ffffff'),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: HexColor(
      'ffffff',
    ),
    iconTheme: IconThemeData(
      color: HexColor('ffffff'),
    ),
  ),
);
ThemeData darkTheme = ThemeData(primarySwatch: Colors.grey);
