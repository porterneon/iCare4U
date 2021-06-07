import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'package:icare4u_ui/services/http_request_helper.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserDetailsApiClient {
  String apiUrl;
  final http.Client httpClient;
  final HttpRequestHelper requestHelper;

  final GlobalSettings _globalSettings = locator<GlobalSettings>();

  UserDetailsApiClient({
    @required this.httpClient,
    @required this.requestHelper,
  }) : assert(httpClient != null && requestHelper != null);

  Future<UserDetails> fetchUserDetails(String userId) async {
    this.apiUrl = _globalSettings.getApiUrl();
    var apiPath = _globalSettings.getUseretailsApiPath();

    final userDetailsUrl = '$apiUrl$apiPath$userId';
    var headerParams = await requestHelper.getRequestAuthenticateHeader();

    final response = await this
        .httpClient
        .get(Uri.parse(userDetailsUrl), headers: headerParams);

    if (response.statusCode != 200) {
      throw Exception('error getting user details');
    }

    if (response.body.length == 0) {
      throw Exception('user details not found');
    }

    final json = jsonDecode(response.body);

    return UserDetails.fromJson(json);
  }
}
