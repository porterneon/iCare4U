class GlobalSettings {
  String getApiUrl() {
    // return 'https://europe-west1-icare4uapi.cloudfunctions.net';
    return 'http://localhost:5000/icare4uapi/europe-west1';
  }

  String getUsersApiPath() {
    return '/api/users';
  }

  String getUseretailsApiPath() {
    return '/api/user/';
  }

  String getPatientsByUserIdApiPath(String userId) {
    return '/api/patientsByUserId/$userId';
  }

  String getPatientDetailsApiPath(String patientId) {
    return '/api/patients/$patientId';
  }

  String getPatientMedicamentsApiPath(String patientId) {
    return '/medicinesByPatientId/$patientId';
  }
}
