import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/widgets/widgets.dart';

class CreateAccount extends StatefulWidget {
  final User user;

  const CreateAccount({Key key, this.user}) : super(key: key);
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String username;
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController;

  final _scaffoldkey = GlobalKey<ScaffoldState>();

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      final SnackBar snackbar = SnackBar(
        content: Text("Welcome $username"),
      );
      _scaffoldkey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context, username);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.user.displayName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: header(context, title: 'Set up your profile',removebackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Create Username",
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  autovalidate: true,
                  validator: (val) {
                    if (val.trim().length < 3 || val.isEmpty) {
                      return 'Username too short';
                    } else if (val.trim().length > 12) {
                      return 'username too long';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) => username = val,
                  controller: usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(
                        fontSize: 15.0,
                      ),
                      hintText: "Must be at least 3 characters",
                      labelText: "Username"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: submit,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
