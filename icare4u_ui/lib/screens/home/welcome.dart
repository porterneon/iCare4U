import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/authenticate/register.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final logo = Hero(
    tag: 'hero',
    child: CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 100.0,
      backgroundImage: AssetImage('assets/logos/logo.png'),
      // child: Image.asset('assets/logos/logo.png'),
    ),
  );

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
                  builder: (BuildContext context) => new LoginScreen()));
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            // fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  // Widget _buildSignUpBtn() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 25.0),
  //     width: double.infinity,
  //     child: RaisedButton(
  //       elevation: 5.0,
  //       onPressed: () {
  //         Navigator.pushReplacement(
  //             context,
  //             new MaterialPageRoute(
  //                 builder: (BuildContext context) => new Register()));
  //       },
  //       padding: EdgeInsets.all(12.0),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(6.0),
  //       ),
  //       color: Colors.white,
  //       child: Text(
  //         'Sign Up',
  //         style: TextStyle(
  //           color: Color(0xFF527DAA),
  //           letterSpacing: 1.5,
  //           fontSize: 18.0,
  //           fontWeight: FontWeight.bold,
  //           // fontFamily: 'OpenSans',
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => new Register()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
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
          onTap: () => FocusScope.of(context).unfocus(),
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
                    SizedBox(height: 30.0),
                    _buildLoginBtn(),
                    // SizedBox(height: 10.0),
                    _buildSignUpBtn(),
                  ],
                ),
              )),
        ),
        value: SystemUiOverlayStyle.light,
      ),
    );
  }
}
