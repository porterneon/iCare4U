import 'package:flutter/material.dart';
import 'package:icare4u_ui/repositories/firebase_auth.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/localizations.dart';

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
            // title: Text(r'Logout'),
            title: Text(AppLocalizations.of(context).translate('logout')),
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
