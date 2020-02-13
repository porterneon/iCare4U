import 'package:http/http.dart' as http;
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/firebase_auth.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'dart:convert';

class RestService {
  String apiUrl;
  String userApiPath;
  final GlobalSettings _globalSettings = locator<GlobalSettings>();

  Future getAllUsersDetails() async {
    try {
      this.apiUrl = _globalSettings.getApiUrl();
      this.userApiPath = _globalSettings.getUsersApiPath();
      var client = new http.Client();
      var path = apiUrl + userApiPath;
      var headerParams = await getRequestAuthenticateHeader();

      var result = await client.get(path, headers: headerParams);

      List<dynamic> users = jsonDecode(result.body);

      return users;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Map<String, String>> getRequestAuthenticateHeader() async {
    // resolve user isntance
    var _user = await locator<AuthService>().user.first;
    final String headerToken = "Bearer " + _user.token;

    Map<String, String> headerParams = {
      "Content-Type": 'application/json',
      "Authorization": headerToken,
    };

    return headerParams;
  }
}
