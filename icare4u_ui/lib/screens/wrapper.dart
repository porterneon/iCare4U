import 'package:icare4u_ui/models/user.dart';
import 'package:icare4u_ui/screens/components/app_drawer.dart';
import 'package:icare4u_ui/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/screens/home/welcome.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/app_language.dart';
import 'package:icare4u_ui/services/firebase_auth.dart';
import 'package:icare4u_ui/utilities/constants.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final auth = locator<AuthService>();

  @override
  Widget build(BuildContext context) {
    final appLanguage = Provider.of<AppLanguage>(context);

    // return either the Home or Authenticate widget
    return Scaffold(
      drawer: AppDrawer(auth: auth, appLanguage: appLanguage),
      appBar: AppBar(
        backgroundColor: appBarDecoration.color,
        elevation: appBarDecoration.elevation,
      ),
      body: Container(
        // Add box decoration
        decoration: globalGradientDecorationStyle,
        child: buildWidget(Provider.of<User>(context)),
        // child: buildCenter(Provider.of<User>(context)),
      ),
    );
  }

  Widget buildWidget(User user) {
    if (user == null) {
      return onLoading(user);
    } else {
      return buildCenter(user);
    }
  }

  FutureBuilder onLoading(User user) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)),
      builder: (c, s) => s.connectionState == ConnectionState.done
          ? buildCenter(user)
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(height: 20.0),
                      new Text("Loading..."),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildCenter(User user) {
    if (user == null) {
      return WelcomeScreen();
    } else {
      return Home();
    }
  }
}
