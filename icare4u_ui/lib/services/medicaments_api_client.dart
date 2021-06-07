import 'package:flutter/cupertino.dart';
import 'package:icare4u_ui/models/medicament.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'package:http/http.dart' as http;
import 'http_request_helper.dart';
import 'dart:convert';

class MedicamentsApiClient {
  String apiUrl;
  final http.Client httpClient;
  final HttpRequestHelper requestHelper;

  final GlobalSettings _globalSettings = locator<GlobalSettings>();

  MedicamentsApiClient({
    @required this.httpClient,
    @required this.requestHelper,
  })  : assert(httpClient != null),
        assert(requestHelper != null);

  Future<List<Medicament>> fetchPatientMedicaments(String patientID) async {
    this.apiUrl = _globalSettings.getApiUrl();
    var apiPath = _globalSettings.getPatientMedicamentsApiPath(patientID);
    var headerParams = await requestHelper.getRequestAuthenticateHeader();

    final requestUrl = '$apiUrl$apiPath';

    final response =
        await this.httpClient.get(Uri.parse(requestUrl), headers: headerParams);

    if (response.statusCode != 200) {
      throw Exception('error getting patient\'s medicaments collection');
    }

    if (response.body.length == 0) {
      throw Exception('patient\'s medicaments not found');
    }

    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    var medicaments =
        parsed.map<Medicament>((json) => Medicament.fromJson(json)).toList();

    return medicaments;
  }
}
