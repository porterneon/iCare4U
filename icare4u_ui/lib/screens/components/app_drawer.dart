import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:icare4u_ui/bloc/user_details_bloc/user_details_bloc.dart';
import 'package:icare4u_ui/repositories/repositories.dart';
import 'package:icare4u_ui/screens/components/user_details_component.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/app_language.dart';
// import 'package:icare4u_ui/services/firebase_auth.dart';
import 'package:icare4u_ui/services/localizations.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context);
    return Drawer(
      elevation: 20.0,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: BlocProvider(
              create: (context) => UserDetailsBloc(
                  userDetailsRepository: locator<UserDetailsRepository>()),
              child: UserDetailsComponent(),
            ),
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
              // await auth.signOut();
              // Navigator.of(context).pop();
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
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
