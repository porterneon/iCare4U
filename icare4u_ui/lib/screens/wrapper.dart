import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    return Scaffold(
      body: Container(
        // Add box decoration
        decoration: BoxDecoration(
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
        ),
        child: buildCenter(user),
      ),
    );
  }

  Widget buildCenter(User user) {
    if (user == null) {
      return LoginScreen();
    } else {
      return Home();
    }
  }
}
