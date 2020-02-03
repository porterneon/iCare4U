import 'package:http/http.dart' as http;
import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  String apiUrl;
  String userApiPath;
  GlobalSettings _globalSettings = GlobalSettings();
  final storage = new FlutterSecureStorage();

  UserService() {
    this.apiUrl = _globalSettings.getApiUrl();
  }

  User _userFromFirebaseUser(String token) {
    return token != null ? User(uid: token) : null;
  }

  // auth change user stream
  Stream<User> get user {
    Stream<String> stream = new Stream.fromFuture(storage.read(key: 'jwt'));
    return stream.map((String token) => _userFromFirebaseUser(token));
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
      print(user['token']);
      await storage.write(key: 'jwt', value: user['token']);
      return _userFromFirebaseUser(user['token']);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      // var client = new http.Client();
      // var apiPath = "/signOut";
      // var path = apiUrl + apiPath;
      // var result = await client.post(path);
      return;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
