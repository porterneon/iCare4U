import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/screens/components/input_text_field.dart';
import 'package:icare4u_ui/screens/wrapper.dart';
import 'package:icare4u_ui/services/auth.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  final AuthService _authService = AuthService();
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

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print(email);
          print(password);
          dynamic result =
              await _authService.signInWithEmailAndPassword(email, password);
          if (result == null) {
            print('error signing in');
          } else {
            print('signed in');
            print(result);
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
                vertical: 120.0,
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
                      setState(() => email = val);
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
                      setState(() => password = val);
                    },
                  ),
                  _buildForgotPasswordBtn(),
                  _buildRememberMeCheckbox(),
                  _buildLoginBtn(),
                  // _buildSignInWithText(),
                  // _buildSocialBtnRow(),
                  // _buildSignupBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget _buildSignInWithText() {
//   return Column(
//     children: <Widget>[
//       Text(
//         '- OR -',
//         style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       SizedBox(height: 20.0),
//       Text(
//         'Sign in with',
//         style: kLabelStyle,
//       ),
//     ],
//   );
// }

// Widget _buildSocialBtn(Function onTap, AssetImage logo) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       height: 60.0,
//       width: 60.0,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black26,
//             offset: Offset(0, 2),
//             blurRadius: 6.0,
//           ),
//         ],
//         image: DecorationImage(
//           image: logo,
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildSocialBtnRow() {
//   return Padding(
//     padding: EdgeInsets.symmetric(vertical: 30.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         _buildSocialBtn(
//           () => print('Login with Facebook'),
//           AssetImage(
//             'assets/logos/facebook.jpg',
//           ),
//         ),
//         _buildSocialBtn(
//           () => print('Login with Google'),
//           AssetImage(
//             'assets/logos/google.jpg',
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildSignupBtn() {
//   return GestureDetector(
//     onTap: () => print('Sign Up Button Pressed'),
//     child: RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: 'Don\'t have an Account? ',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           TextSpan(
//             text: 'Sign Up',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
