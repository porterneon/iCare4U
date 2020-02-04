import 'dart:async';

import 'package:icare4u_ui/models/user.dart';

class TokenChangeController {
  User _userFromFirebaseUser(String token) {
    return token != null ? User(uid: token) : null;
  }

  final StreamController<String> changeController =
      new StreamController<String>();

  Stream<User> get onChange => changeController.stream
      .map((String token) => _userFromFirebaseUser(token));
}
