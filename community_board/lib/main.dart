import 'package:flutter/material.dart';
import 'package:community_board/board_firestore/board-app.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BoardApp(),
    );
  }
}
