import 'package:flutter/material.dart';
import 'package:flutter_social_media/widgets/widgets.dart';

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,isAppTitle: true),
      body: linearProgressBar(context),
    );
  }
}