import 'dart:io';
import 'package:flutter/foundation.dart' as Foundation;

class GlobalSettings {
  String getApiUrl() {
    if (Foundation.kDebugMode) {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:5000/icare4uapi/europe-west1'; // for android emulator
      } else if (Platform.isIOS) {
        return 'http://localhost:5000/icare4uapi/europe-west1'; // for iOS symulator
      } else {
        return 'https://europe-west1-icare4uapi.cloudfunctions.net';
      }
    } else {
      return 'https://europe-west1-icare4uapi.cloudfunctions.net';
    }
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
