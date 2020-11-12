import 'dart:ui';

import 'package:flutter/material.dart';

AppBar header(BuildContext context, {bool isAppTitle= false, String title,bool removebackButton= false}) {
  return AppBar(
    automaticallyImplyLeading: !removebackButton,
    title: (isAppTitle)
        ? Text(
            "Social Media",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Signatra",
              fontSize: 50,
            ),
          )
        : Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0
            ),
          ),
    backgroundColor: Theme.of(context).accentColor,
    centerTitle: true,
  );
}
