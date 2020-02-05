import 'package:icare4u_ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/home/welcome.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/auth.dart';
import 'package:icare4u_ui/services/localizations.dart';
import 'package:icare4u_ui/utilities/constants.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final appLanguage = Provider.of<AppLanguage>(context);

    // return either the Home or Authenticate widget
    return Scaffold(
      drawer: AppDrawer(auth: auth, appLanguage: appLanguage),
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0.0,
      ),
      body: Container(
        // Add box decoration
        decoration: globalGradientDecorationStyle,
        child: buildCenter(user),
      ),
    );
  }

  Widget buildCenter(User user) {
    print(">>>> User: $user");
    if (user == null) {
      return WelcomeScreen();
      // return LoginScreen();
    } else {
      return Home();
    }
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
    @required this.auth,
    @required this.appLanguage,
  }) : super(key: key);

  final AuthService auth;
  final AppLanguage appLanguage;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 20.0,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            // title: Text('Profile'),
            title: Text(AppLocalizations.of(context).translate('Profile')),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(r'Settings'),
          ),
          ListTile(
            title: Text(r'Logout'),
            leading: Icon(Icons.person),
            onTap: () async {
              // await _userService.signOut();
              await auth.signOut();
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    appLanguage.changeLanguage(Locale("en"));
                  },
                  child: Text('English'),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    appLanguage.changeLanguage(Locale("pl"));
                  },
                  child: Text('Polski'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
