// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_social_media/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_social_media/auth.dart';
import 'package:flutter_social_media/pages/pages.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // Firebase.initializeApp();
    googleLoggedIncheck().then((result) {
      print(result);
      setState(() {
        isAuth = result;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  User user;

  login() async {
    //final _authResult = await googleSignIn.signIn();
    signInWithGoogle().then((result) {
      this.user = result;
      setState(() => isAuth = result != null);
    });
  }

  logout() {
    googleSignIn.signOut();
    setState(() => isAuth = false);
  }

  onPageChanged(int pageIn) {
    setState(() {
      pageIndex = pageIn;
    });
  }

  onTap(int pageIn) {
    pageController.animateToPage(
      pageIn,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  _buildAuthScreen() {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 35.0,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        ],
      ),
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
              onTap: () {
                login();
                // signInWithGoogle().then((result){
                //   if(result!=null){
                //     setState(() {
                //       isAuth = true;
                //     });
                //   }
                // });
              },
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
