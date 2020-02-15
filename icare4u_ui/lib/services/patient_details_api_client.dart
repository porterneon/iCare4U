import 'package:icare4u_ui/models/patient.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'package:icare4u_ui/services/http_request_helper.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PatientDetailsApiClient {
  String apiUrl;
  final http.Client httpClient;
  final HttpRequestHelper requestHelper;

  final GlobalSettings _globalSettings = locator<GlobalSettings>();

  PatientDetailsApiClient({
    @required this.httpClient,
    @required this.requestHelper,
  })  : assert(httpClient != null),
        assert(requestHelper != null);

  Future<List<Patient>> fetchUsersPatientsDetails(String userId) async {
    this.apiUrl = _globalSettings.getApiUrl();
    var apiPath = _globalSettings.getPatientsByUserIdApiPath(userId);
    var headerParams = await requestHelper.getRequestAuthenticateHeader();

    final requestUrl = '$apiUrl$apiPath';

    final response =
        await this.httpClient.get(requestUrl, headers: headerParams);

    if (response.statusCode != 200) {
      throw Exception('error getting patient collection');
    }

    if (response.body.length == 0) {
      throw Exception('patients not found');
    }

    var body = response.body;
    print('print patient colection: $body');

    var patients = (jsonDecode(response.body) as List<dynamic>).cast<Patient>();

    return patients;
  }
}
