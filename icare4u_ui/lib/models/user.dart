import 'package:flutter/foundation.dart';

class AppUser {
  final String uid;
  final String token;
  final String email;

  AppUser({
    @required this.uid,
    this.token,
    this.email,
  });
}
