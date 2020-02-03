import 'package:http/http.dart' as http;
import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'dart:convert';

import 'package:icare4u_ui/services/secure_storage.dart';

class UserService {
  String apiUrl;
  String userApiPath;
  GlobalSettings _globalSettings = GlobalSettings();
  final SecureStorage _storage = SecureStorage();

  UserService() {
    this.apiUrl = _globalSettings.getApiUrl();
  }

  User _userFromFirebaseUser(String token) {
    print("user token: $token");
    return token != null ? User(uid: token) : null;
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

  Future logIn(String email, String password) async {
    try {
      final credentials = {"email": email, "password": password};

      var client = new http.Client();
      var apiPath = "/login";
      var path = apiUrl + apiPath;
      var result = await client.post(path, body: credentials);

      Map<String, dynamic> user = jsonDecode(result.body);
      // print(user['token']);
      var token = await _storage.write('jwt', user['token']);
      return _userFromFirebaseUser(token);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      print("signing out...");
      await _storage.delete('jwt');
      return;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
