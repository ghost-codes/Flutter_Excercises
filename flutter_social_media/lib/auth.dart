import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/models/models.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_social_media/pages/pages.dart';
import 'package:flutter_social_media/util.dart';




 Users currentUser;

Future<User> signInWithGoogle() async {
  Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final UserCredential authResult =
      await auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentuser = auth.currentUser;

  assert(currentuser.uid == user.uid);

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await auth.signOut();
}

Future<bool> googleLoggedIncheck() async {
  final currentuser = auth.currentUser;
  DocumentSnapshot doc = await usersRef.doc(currentuser.uid).get();
    currentUser = Users.fromDocument(doc);
  return (currentuser != null);
}

 createUserInFireStore(BuildContext context, User user) async {
  //Check if user exists in Firestore Database
  DocumentSnapshot doc = await usersRef.doc(user.uid).get();

  if (!doc.exists) {
    final username = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateAccount(user: user),
      ),
    );

    usersRef.doc(user.uid).set({
      "id": user.uid,
      "username": username,
      "photoUrl": user.photoURL,
      "email": user.email,
      "displayname": user.displayName,
      "bio":"",
      "timestamp": timestamp,
    });
    doc = await usersRef.doc(user.uid).get();
  }
  currentUser = Users.fromDocument(doc);
  print(currentUser.username);
}
