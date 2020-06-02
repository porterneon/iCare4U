import 'package:icare4u_ui/models/models.dart';

class PatientCache {
  List<Patient> patients;
  Map<String, Patient> patientsDetails;

  PatientCache() {
    patients = new List<Patient>();
    patientsDetails = new Map<String, Patient>();
  }
}
