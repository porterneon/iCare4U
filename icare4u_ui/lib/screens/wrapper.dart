// import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/home/welcome.dart';
import 'package:icare4u_ui/services/auth.dart';
import 'package:icare4u_ui/utilities/constants.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    // return either the Home or Authenticate widget
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.person),
              onTap: () async {
                await _auth.signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
      ),
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
