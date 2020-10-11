import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final globalGradientDecorationStyle = BoxDecoration(
  // Box decoration takes a gradient
  gradient: LinearGradient(
    // Add one stop for each color. Stops should increase from 0 to 1
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF73AEF5),
      Color(0xFF61A4F1),
      Color(0xFF478DE0),
      Color(0xFF398AE5),
    ],
    stops: [0.1, 0.4, 0.7, 0.9],
  ),
);

final appBarDecoration = AppBarTheme(
  elevation: 0.0,
  color: Color(0xFF73AEF5),
);

final getSystemUiOverlayStyle = SystemUiOverlayStyle.light;

final globalBackgroundColor = Color.fromARGB(255, 228, 242, 253);
