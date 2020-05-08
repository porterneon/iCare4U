import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/services/patient_details_api_client.dart';

class PatientDetailsRepository {
  final PatientDetailsApiClient apiClient;
  List<Patient> patients;

  PatientDetailsRepository({@required this.apiClient})
      : assert(apiClient != null) {
    patients = new List<Patient>();
  }

  Future<List<Patient>> getPatientCollection() async {
    return patients;
  }

  Future<List<Patient>> fetchPatientCollection(String userId) async {
    if (userId == null || userId.length == 0) return new List<Patient>();

    patients = await apiClient.fetchUsersPatientsDetails(userId);
    return patients;
  }

  Future<String> addPatientDetails(Patient patient) async {
    return apiClient.addPatientDetails(patient);
  }

  Future<String> updatePatientDetails(Patient patient) async {
    return apiClient.updatePatientDetails(patient);
  }

  Future<bool> deletePatientDetails(String patientId) async {
    return apiClient.deletePatientDetails(patientId);
  }

  Future<Patient> fetchPatientDetials(String patientId) async {
    return apiClient.fetchPatientDetails(patientId);
  }
}
