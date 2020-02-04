import 'package:http/http.dart' as http;
import 'package:icare4u_ui/services/global_settings.dart';
import 'dart:convert';

import 'package:icare4u_ui/services/secure_storage.dart';
import 'package:icare4u_ui/services/token_change_controller.dart';

class UserAuthService {
  String apiUrl;
  String userApiPath;
  final GlobalSettings _globalSettings = GlobalSettings();
  SecureStorage storage;
  final String tokenKey = 'jwt';

  UserAuthService(TokenChangeController tck) {
    this.apiUrl = _globalSettings.getApiUrl();
    this.storage = new SecureStorage(tck);
  }

  Future getAllUsersDetails() async {
    try {
      this.userApiPath = _globalSettings.getUsersApiPath();
      var client = new http.Client();
      var path = apiUrl + userApiPath;
      var result = await client.get(path);
      print(result.body);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future logIn(String email, String password, bool rememberMe) async {
    try {
      final credentials = {"email": email, "password": password};

      var client = new http.Client();
      var apiPath = "/login";
      var path = apiUrl + apiPath;
      var result = await client.post(path, body: credentials);

      Map<String, dynamic> user = jsonDecode(result.body);

      return await storage.write(tokenKey, user['token'], rememberMe);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      print("signing out...");
      await storage.delete(tokenKey);
      return;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
