import 'package:flutter/material.dart';
import 'package:flutter_social_media/widgets/widgets.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,isAppTitle: false, title: "Profile"),
      body: Center(child: Text('Profile'),),
    );
  }
}