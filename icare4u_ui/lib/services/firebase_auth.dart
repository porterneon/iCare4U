import 'package:firebase_auth/firebase_auth.dart';
import 'package:icare4u_ui/models/user.dart';

class AuthService {
  final String tokenKey = 'jwt';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> _userFromFirebaseUser(FirebaseUser user) async {
    if (user == null) return null;

    var token = (await user.getIdToken())?.token;
    // print(token);
    return user != null ? User(uid: user.uid, token: token) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.asyncMap(
        (FirebaseUser firebaseUser) => _userFromFirebaseUser(firebaseUser));
  }

  // // sign in anon
  // Future signInAnon() async {
  //   try {
  //     print('signInAnon...');
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     print(user.uid);
  //     return await _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return await _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return await _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
