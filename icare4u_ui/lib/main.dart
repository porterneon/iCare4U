import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/home/second_screen.dart';
import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        )
      ],
      child: MaterialApp(
        title: 'iCare4U',
        // home: Wrapper(),
        theme: ThemeData(
          backgroundColor: Colors.white,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(color: Color(0xff01A0C7)),
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
