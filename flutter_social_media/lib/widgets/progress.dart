import 'package:flutter/material.dart';

Container circularProgressBar(BuildContext context){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top:10),
    child: CircularProgressIndicator(
      valueColor:AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    ),
  );
}

Container linearProgressBar(BuildContext context){
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor:AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    ),
  );
}