import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        backgroundImage: AssetImage('assets/logos/logo.png'),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        child: GestureDetector(
          // onTap: () => FocusScope.of(context).unfocus(),
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
                    CircularProgressIndicator(),
                    SizedBox(height: 30.0),
                    Text('Welcome'),
                  ],
                ),
              )),
        ),
        value: getSystemUiOverlayStyle,
      ),
    );
  }
}
