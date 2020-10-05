import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/medicament.dart';
import 'package:icare4u_ui/services/medicament_cache.dart';
import 'package:icare4u_ui/services/medicaments_api_client.dart';

class MedicamentsRepository {
  final MedicamentsApiClient apiClient;
  MedicamentCache medicamentCache;

  MedicamentsRepository({
    @required this.medicamentCache,
    @required this.apiClient,
  }) : assert(apiClient != null);

  Future<List<Medicament>> getMedicamentCollection() async {
    return medicamentCache.medicaments;
  }

  Future<List<Medicament>> fetchMedicamentCollection(String patientId) async {
    if (patientId == null || patientId.length == 0)
      return new List<Medicament>();

    medicamentCache.medicaments =
        await apiClient.fetchPatientMedicaments(patientId);

    return medicamentCache.medicaments;
  }
}
