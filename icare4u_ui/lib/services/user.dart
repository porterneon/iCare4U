import 'package:http/http.dart' as http;
import 'package:icare4u_ui/services/global_settings.dart';

class UserService {
  String apiUrl;
  String userApiPath;
  GlobalSettings _globalSettings = GlobalSettings();

  UserService() {
    this.apiUrl = _globalSettings.getApiUrl();
    this.userApiPath = _globalSettings.getUsersApiPath();
  }

  Future getAllUsersDetails() async {
    try {
      var client = new http.Client();
      var path = apiUrl + userApiPath;
      var result = await client.get(path);
      print(result.body);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
