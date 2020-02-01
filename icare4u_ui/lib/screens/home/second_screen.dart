import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Second screen'),
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0.0,
      ),
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
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text('second screen'),
                    RaisedButton(
                      onPressed: () {
                        // Navigate back to the first screen by popping the current route
                        // off the stack.
                        Navigator.pop(context);
                      },
                      child: Text('Go back!'),
                    ),
                  ],
                ),
              )),
        ),
        value: SystemUiOverlayStyle.light,
      ),
    );
  }
}
