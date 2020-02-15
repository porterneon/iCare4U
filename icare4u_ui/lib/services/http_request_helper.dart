import 'package:flutter/material.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

class HttpRequestHelper {
  UserRepository userRepository;

  HttpRequestHelper({
    @required this.userRepository,
  }) : assert(userRepository != null);

  Future<Map<String, String>> getRequestAuthenticateHeader() async {
    var _user = await userRepository.getUser();
    final String headerToken = "Bearer " + _user.token;

    Map<String, String> headerParams = {
      "Content-Type": 'application/json',
      "Authorization": headerToken,
    };

    return headerParams;
  }
}
