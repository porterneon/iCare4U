import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/home/second_screen.dart';
import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/auth.dart';
import 'package:icare4u_ui/services/localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await locator<AppLanguage>().fetchLocale();
  runApp(new MaterialApp(
    home: AplashApp(),
  ));
}

class AplashApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<AplashApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new MyApp(),
        title: new Text(
          'Welcome In iCare4U',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: new Image.asset('assets/logos/logo.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        // onClick: () => print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(
          create: (context) => locator<AppLanguage>(),
        ),
        StreamProvider<User>.value(
          value: locator<AuthService>().user,
        ),
      ],
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
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
          // home: await getLandingPage(),
          theme: ThemeData(
            backgroundColor: Colors.black,
            brightness: Brightness.dark,
            appBarTheme: AppBarTheme(
              color: Color(0xff01A0C7),
              elevation: 0.0,
            ),
            fontFamily: 'OpenSans',
          ),
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => Wrapper(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            '/second': (context) => SecondScreen(),
            '/loginScreen': (context) => LoginScreen(),
          },
        );
      }),
    );
  }
}
