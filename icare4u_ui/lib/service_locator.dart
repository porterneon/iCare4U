import 'package:get_it/get_it.dart';
import 'package:icare4u_ui/models/user_details.dart';
import 'package:icare4u_ui/repositories/repositories.dart';
import 'package:icare4u_ui/repositories/user_repository.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/app_shared_preferences.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'package:http/http.dart' as http;
import 'package:icare4u_ui/services/http_request_helper.dart';
import 'package:icare4u_ui/services/user_details_api_client.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<GlobalSettings>(() => GlobalSettings());

  locator.registerSingleton(AppLanguage());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());

  locator.registerFactory<HttpRequestHelper>(
      () => HttpRequestHelper(userRepository: locator<UserRepository>()));
  locator.registerFactory<UserDetailsRepository>(
    () => UserDetailsRepository(
      apiClient: UserDetailsApiClient(
        httpClient: http.Client(),
        requestHelper: locator<HttpRequestHelper>(),
      ),
    ),
  );
  locator.registerLazySingleton<UserDetails>(() => new UserDetails());
  locator.registerFactory<AppSharedPreferences>(() => AppSharedPreferences());
}
