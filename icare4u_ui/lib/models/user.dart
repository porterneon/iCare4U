import 'package:flutter/foundation.dart';

class User {
  final String uid;
  final String token;
  final String email;

  User({
    @required this.uid,
    this.token,
    this.email,
  });
}
