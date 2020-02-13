import 'dart:async';

import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/repositories/user_details_api_client.dart';
import 'package:meta/meta.dart';

class UserDetailsRepository {
  final UserDetailsApiClient apiClient;

  UserDetailsRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<UserDetails> getuserDetals(String userId) async {
    return apiClient.fetchUserDetails(userId);
  }
}
