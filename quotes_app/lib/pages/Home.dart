
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _index = 0;

  final List<String> _quotes = [
    "Your limitation—it's only your imagination.",
    "Push yourself, because no one else is going to do it for you.",
    "Sometimes later becomes never. ...",
    "Great things never come from comfort zones.",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_quotes[_index % _quotes.length],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              FlatButton.icon(
                  onPressed: _inspire,
                  icon: Icon(
                    Icons.brightness_7_rounded,
                    color: Colors.black,
                  ),
                  label: Text("Inspire Me",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      )
                  )
              ),
            ],
          )
      ),
    );
  }

   void _inspire() {
    setState(() {
      _index += 1;
    });
  }
}


