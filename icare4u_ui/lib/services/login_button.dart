import 'package:flutter/material.dart';
import 'package:icare4u_ui/services/auth.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required AuthService authService,
    @required this.style,
  })  : _authService = authService,
        super(key: key);

  final AuthService _authService;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          dynamic result = await _authService.signInAnon();
          if (result == null) {
            print('error signing in');
          } else {
            print('signed in');
            print(result);
          }
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
