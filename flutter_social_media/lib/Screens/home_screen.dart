import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      handleSginIn(account);
    }, onError: ((err) {
      print('Error on SignIn: $err');
    }));

    googleSignIn
        .signInSilently(suppressErrors: false)
        .then((account) => handleSginIn(account))
        .catchError((err) {
      print('Error on SignIn: $err');
    });
  }

  handleSginIn(account) {
    if (account != null) {
      print(account);
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  _buildAuthScreen() {
    return RaisedButton(
      onPressed: logout(),
      child: Text('Logout'),
    );
  }

  _buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor,
              ]),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Social Media",
              style: TextStyle(
                fontFamily: "Signatra",
                fontSize: 90.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: login(),
              child: Container(
                width: 260.00,
                height: 60.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/google_signin_button.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? _buildAuthScreen() : _buildUnAuthScreen();
  }
}
