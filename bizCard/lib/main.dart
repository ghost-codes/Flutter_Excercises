import 'package:flutter/material.dart';
import 'package:bizCard/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      title: "Biz Card",
      home: Home(),
    );
  }
}