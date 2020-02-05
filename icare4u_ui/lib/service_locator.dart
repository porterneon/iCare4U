import 'package:get_it/get_it.dart';
import 'package:icare4u_ui/services/secure_storage.dart';
import 'package:icare4u_ui/services/token_change_controller.dart';
import 'package:icare4u_ui/services/user_auth.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(TokenChangeController());
  locator.registerFactory<UserAuthService>(() => UserAuthService());
  locator.registerFactory<SecureStorage>(() => SecureStorage());
}
