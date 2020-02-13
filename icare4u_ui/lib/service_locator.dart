import 'package:get_it/get_it.dart';
import 'package:icare4u_ui/repositories/firebase_auth.dart';
import 'package:icare4u_ui/repositories/repositories.dart';
import 'package:icare4u_ui/repositories/rest_call.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/global_settings.dart';
import 'package:http/http.dart' as http;

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<GlobalSettings>(() => GlobalSettings());
  locator.registerSingleton(AppLanguage());
  locator.registerFactory<AuthService>(() => AuthService());
  locator.registerFactory<RestService>(() => RestService());
  locator.registerFactory<UserDetailsRepository>(() => UserDetailsRepository(
      apiClient: UserDetailsApiClient(httpClient: http.Client())));
}
