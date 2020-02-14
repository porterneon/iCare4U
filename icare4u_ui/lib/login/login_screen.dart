import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/login/bloc/bloc.dart';
import 'package:icare4u_ui/login/login_form.dart';
import 'package:icare4u_ui/repositories/user_repository.dart';
import 'package:icare4u_ui/screens/home/welcome_screen.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getSystemUiOverlayStyle,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: globalGradientDecorationStyle,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: appBarDecoration.color,
              elevation: 0.0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: 'Back',
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new WelcomeScreen()));
                },
              ),
            ),
            backgroundColor: Colors.transparent,
            body: BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: _userRepository),
              child: LoginForm(userRepository: _userRepository),
            ),
          ),
        ),
      ),
    );
  }
}
