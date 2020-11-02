import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quiz_app/pages/home.dart';

void main ()=> runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //primaryColor: Colors.white,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          body1: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      home: Home(),
    );
  }
}