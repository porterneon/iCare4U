import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/home/second_screen.dart';
import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/services/secure_storage.dart';
import 'package:icare4u_ui/services/token_change_controller.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final TokenChangeController _tokenChangeController =
      new TokenChangeController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TokenChangeController>(create: (_) => _tokenChangeController),
        StreamProvider<User>.value(
          value: _tokenChangeController.onChange,
        ),
        FutureProvider<String>.value(
            value: SecureStorage(_tokenChangeController).readUserToken())
      ],
      child: MaterialApp(
        title: 'iCare4U',
        // home: Wrapper(),
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
      ),
    );
  }
}
