import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async{
  Firebase.initializeApp();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken()!=null);

  final User currentuser =  _auth.currentUser;

  assert(currentuser.uid == user.uid);

  return user;
}

void signOutGoogle()async{
  await googleSignIn.signOut();
}

Future<bool> googleLoggedIncheck()async{
  final currentuser =  _auth.currentUser;
  return (currentuser != null);
}