import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/screens/components/app_drawer.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: appBarDecoration.color,
        elevation: appBarDecoration.elevation,
      ),
      // backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: getSystemUiOverlayStyle,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: globalGradientDecorationStyle,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 80,
                    width: double.infinity,
                    decoration: new BoxDecoration(
                      color: appBarDecoration.color,
                      borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(30.0)),
                    ),
                    child: Text(
                      "This is temporary text...",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                  Container(
                    child: Text('home'),
                  ),
                  RaisedButton(
                    child: Text('Launch screen'),
                    onPressed: () {
                      // Navigate to the second screen using a named route.
                      Navigator.pushNamed(context, '/second');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
