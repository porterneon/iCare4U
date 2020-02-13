import 'dart:async';

import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/app_shared_preferences.dart';
import 'package:icare4u_ui/services/user_details_api_client.dart';
import 'package:meta/meta.dart';

class UserDetailsRepository {
  final UserDetailsApiClient apiClient;

  UserDetailsRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<UserDetails> getUserDetals(String userId) async {
    var localDetails = await locator<AppSharedPreferences>().getUserDetails();

    if (localDetails == null || localDetails.userName == null) {
      var userDetails = await apiClient.fetchUserDetails(userId);
      await saveLocalUserDetails(userDetails);
      return userDetails;
    }
    return localDetails;
  }

  Future saveLocalUserDetails(UserDetails userDetails) async {
    await locator<AppSharedPreferences>().saveUserDetails(userDetails);
  }

  Future deleteLocalUserDetails() async {
    await locator<AppSharedPreferences>().deleteUserDetails();
  }
}
