import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/screens/components/input_text_field.dart';
import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/firebase_auth.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = locator<AuthService>();

  String email = '';
  String password = '';

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  void onLogging() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.blue[200],
              borderRadius: new BorderRadius.circular(10.0),
            ),
            width: 300.0,
            height: 200.0,
            alignment: AlignmentDirectional.center,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 20.0),
                new Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    if (result == null) {
      print('error signing in');
    } else {
      print('signed in');
      // var landingPage = await getLandingPage();
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
    }
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => onLogging(),
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Wrapper()));
          },
        ),
      ),
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: globalGradientDecorationStyle,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      // fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  InputTextField(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    iconData: Icons.email,
                    textInputType: TextInputType.emailAddress,
                    onChanged: (val) {
                      setState(() => email = val.trim());
                    },
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InputTextField(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    iconData: Icons.lock,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val.trim());
                    },
                  ),
                  _buildForgotPasswordBtn(),
                  // _buildRememberMeCheckbox(),
                  _buildLoginBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
