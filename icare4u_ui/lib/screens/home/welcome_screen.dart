import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/login/login_screen.dart';
import 'package:icare4u_ui/register/register_screen.dart';
import 'package:icare4u_ui/repositories/user_repository.dart';
import 'package:icare4u_ui/screens/components/logo.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/localizations.dart';
import 'package:icare4u_ui/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new LoginScreen(
                userRepository: locator<UserRepository>(),
              ),
            ),
          );
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: Colors.white,
        child: Text(
          // 'Sign In',
          AppLocalizations.of(context).translate('sign_in'),
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) => new RegisterScreen(
              userRepository: locator<UserRepository>(),
            ),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          children: <InlineSpan>[
            WidgetSpan(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  // 'dont_have_account',
                  AppLocalizations.of(context).translate('dont_have_account'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            WidgetSpan(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  // 'sign_up',
                  AppLocalizations.of(context).translate('sign_up'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        child: GestureDetector(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              // Add box decoration
              decoration: globalGradientDecorationStyle,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    logo,
                    SizedBox(height: 10.0),
                    _buildLoginBtn(),
                    _buildSignUpBtn(),
                  ],
                ),
              )),
        ),
        value: getSystemUiOverlayStyle,
      ),
    );
  }
}
