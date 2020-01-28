import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iCare4U',
      home: Wrapper(),
      theme: ThemeData(
          backgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Color(0xff01A0C7))),
    );
  }
}
