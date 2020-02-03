import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:icare4u_ui/models/user.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  User _userFromFirebaseUser(String token) {
    print("user token: $token");
    return token != null ? User(uid: token) : null;
  }

  final changeController = new StreamController<String>();
  Stream<User> get onChange {
    print("user stream changed value");
    return changeController.stream
        .map((String token) => _userFromFirebaseUser(token));
  }

  Future _doneFuture;
  SecureStorage() {
    _doneFuture = readUserToken();
  }

  Future get initializationDone => _doneFuture;

  Future readUserToken() async {
    var token = await storage.read(key: 'jwt');
    changeController.add(token);
  }

  Future write(String key, String token) async {
    await storage.write(key: key, value: token);
    changeController.add(token);
    return token;
  }

  Future delete(String key) async {
    await storage.delete(key: 'jwt');
    changeController.add(null);
  }
}
