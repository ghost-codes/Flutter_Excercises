import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayname;
  final String bio;

  Users({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayname,
    this.bio,
  });

  factory Users.fromDocument(DocumentSnapshot doc){
    return Users(
      id: doc['id'],
      username: doc['username'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      displayname: doc['displayname'],
      bio: doc['bio'],
    );
  }
}
