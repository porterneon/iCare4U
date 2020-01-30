// import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/home/welcome.dart';
import 'package:icare4u_ui/utilities/constants.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    return Scaffold(
      body: Container(
        // Add box decoration
        decoration: globalGradientDecorationStyle,
        child: buildCenter(user),
      ),
    );
  }

  Widget buildCenter(User user) {
    if (user == null) {      
      return WelcomeScreen();
      // return LoginScreen();
    } else {
      return Home();
    }
  }
}
