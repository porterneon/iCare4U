import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/services/patient_details_api_client.dart';

class PatientDetailsRepository {
  final PatientDetailsApiClient apiClient;

  PatientDetailsRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List<Patient>> fetchPatientCollection(String userId) async {
    return apiClient.fetchUsersPatientsDetails(userId);
  }
}
