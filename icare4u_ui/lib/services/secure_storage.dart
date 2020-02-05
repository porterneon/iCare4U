import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:icare4u_ui/service_locator.dart';
// import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/services/token_change_controller.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  var _tokenChangeController = locator<TokenChangeController>();

  Future<String> readUserToken() async {
    var token = await storage.read(key: 'jwt');
    _tokenChangeController.changeController.add(token);
    print("initialized storage class");
    return token;
  }

  Future write(String key, String token, bool rememberMe) async {
    print("token saved in sorage");
    _tokenChangeController.changeController.add(token);
    print("token change added");
    if (rememberMe) {
      await storage.write(key: key, value: token);
    }
    return token;
  }

  Future delete(String key) async {
    await storage.delete(key: 'jwt');
    _tokenChangeController.changeController.add(null);
  }
}
