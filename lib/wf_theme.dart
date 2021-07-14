import 'package:flutter/material.dart';

class WFTheme {
  static getTheme() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'OtomanopeeOne',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
          headline4: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.white),
          bodyText2: TextStyle(fontSize: 18.0, color: Colors.white),
          subtitle1: TextStyle(fontSize: 14.0, color: Colors.red),
        ),
      );
}
