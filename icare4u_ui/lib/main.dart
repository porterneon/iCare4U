import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:icare4u_ui/login/login_screen.dart';
import 'package:icare4u_ui/repositories/user_repository.dart';
import 'package:icare4u_ui/screens/home/home_screen.dart';
import 'package:icare4u_ui/screens/home/second_screen.dart';
import 'package:icare4u_ui/screens/home/splash_screen.dart';
import 'package:icare4u_ui/screens/home/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/localizations.dart';
import 'package:icare4u_ui/simple_bloc_delegate.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  setupLocator();
  await locator<AppLanguage>().fetchLocale();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(
          create: (context) => locator<AppLanguage>(),
        ),
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: locator<UserRepository>())
                ..add(
                  AppStarted(),
                ),
        ),
      ],
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Uninitialized) {
                return SplashScreen();
              }
              if (state is Unauthenticated) {
                return WelcomeScreen();
              }
              if (state is Authenticated) {
                var userId = state.userId;
                return Home(
                  userId: userId,
                );
              } else {
                return WelcomeScreen();
              }
            },
          ),
          locale: model.appLocal,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('pl', 'PL'),
          ],
          title: 'iCare4U',
          theme: ThemeData(
            brightness: Brightness.light,
            appBarTheme: AppBarTheme(
              color: Color(0xff01A0C7),
              elevation: 0.0,
            ),
            fontFamily: 'OpenSans',
          ),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            // '/': (context) => Wrapper(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => SecondScreen(),
            '/loginScreen': (context) => LoginScreen(
                  userRepository: locator<UserRepository>(),
                ),
          },
        );
      }),
    );
  }
}
