import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mortgage_payment_starter_app/ui/JsonParsing.dart';
import 'package:mortgage_payment_starter_app/ui/mortgage_app.dart';

ThemeData _buildThemeData (){
  ThemeData base = ThemeData();

  return base.copyWith(
    primaryColor: Color(0xFF34cb5d)
  );
}


void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  //theme:_buildThemeData(),
  theme: ThemeData(
    primaryColor: Color(0xFF34cb5d),
    accentColor: Color(0xFFe59fba),

    textTheme: TextTheme(
      headline6: TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w500
      ),
      headline5: TextStyle(
          fontSize: 18,
        //fontWeight: FontWeight.bold,
        color: Color(0xffb2708a)
      ),

      headline4: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
          color: Color(0xffb2708a)
      )
    )
  ),
  home: JsonParsing(),
));