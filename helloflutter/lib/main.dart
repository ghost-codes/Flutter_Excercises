import 'dart:ui';

import 'package:flutter/material.dart';

void main () => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        canvasColor: Colors.white,
      ),
      title: 'hello World',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  void _tapButton(){
    debugPrint('Tapped');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Text("Scaffold"),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 5,
              )
              ]
            ),
            child: IconButton(icon: Icon(Icons.access_alarm_rounded),
            onPressed: ()=>_tapButton(),
            )
          ),

           Container(
             margin: EdgeInsets.symmetric(horizontal:10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 5,
              )
              ]
            ),
            child: IconButton(icon: Icon(Icons.email_outlined),
            onPressed: ()=>_tapButton(),
            )
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal:10),
        child: Center(
          child:Text("Hello World",
          style: TextStyle(
            color: Colors.black,
            fontSize: 38,
          ),),
        ),
    ),
    );
  }
}