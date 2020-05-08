import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/services/patient_cache.dart';
import 'package:icare4u_ui/services/patient_details_api_client.dart';

class PatientDetailsRepository {
  final PatientDetailsApiClient apiClient;
  PatientCache patientCache;

  PatientDetailsRepository(
      {@required this.patientCache, @required this.apiClient})
      : assert(apiClient != null);

  Future<List<Patient>> getPatientCollection() async {
    return patientCache.patients;
  }

  Future<List<Patient>> fetchPatientCollection(String userId) async {
    if (userId == null || userId.length == 0) return new List<Patient>();

    patientCache.patients = await apiClient.fetchUsersPatientsDetails(userId);
    return patientCache.patients;
  }

  Future<String> addPatientDetails(Patient patient) async {
    return apiClient.addPatientDetails(patient);
  }

  Future<String> updatePatientDetails(Patient patient) async {
    if (patientCache.patientsDetails.containsKey(patient.patientId)) {
      patientCache.patientsDetails
          .update(patient.patientId, (value) => patient);
    } else {
      patientCache.patientsDetails
          .putIfAbsent(patient.patientId, () => patient);
    }

    return apiClient.updatePatientDetails(patient);
  }

  Future<bool> deletePatientDetails(String patientId) async {
    if (patientCache.patientsDetails.containsKey(patientId)) {
      patientCache.patientsDetails.remove(patientId);
    }

    return apiClient.deletePatientDetails(patientId);
  }

  Future<Patient> getCachedPatientDetials(String patientId) async {
    if (patientCache.patientsDetails.containsKey(patientId)) {
      return patientCache.patientsDetails[patientId];
    }

    var details = await apiClient.fetchPatientDetails(patientId);
    patientCache.patientsDetails.putIfAbsent(details.patientId, () => details);

    return details;
  }

  Future<Patient> fetchPatientDetials(String patientId) async {
    return apiClient.fetchPatientDetails(patientId);
  }
}
