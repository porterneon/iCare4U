import 'package:get_it/get_it.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/auth.dart';
import 'package:icare4u_ui/services/global_settings.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory<GlobalSettings>(() => GlobalSettings());
  locator.registerSingleton(AppLanguage());
  locator.registerFactory<AuthService>(() => AuthService());
}
