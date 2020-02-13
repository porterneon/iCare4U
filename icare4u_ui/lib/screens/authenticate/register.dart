import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/screens/authenticate/login.dart';
import 'package:icare4u_ui/screens/components/input_text_field.dart';
import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/services/firebase_auth.dart';
// import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = locator<AuthService>();

  String email = '';
  String password = '';
  String confirmPassword = '';

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print(email);
          print(password);
          dynamic result =
              await _auth.registerWithEmailAndPassword(email, password);
          if (result == null) {
            print('error signing up');
          } else {
            print('signed up');
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Wrapper()));
          }
        },
        padding: EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        color: Colors.white,
        child: Text(
          'SIGNUP',
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
                    'Sign Up',
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
                  SizedBox(
                    height: 30.0,
                  ),
                  InputTextField(
                    labelText: 'Confirm Password',
                    hintText: 'Enter your Password',
                    iconData: Icons.lock,
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => confirmPassword = val.trim());
                    },
                  ),
                  _buildSignUpBtn(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new LoginScreen()));
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Have an Account? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
