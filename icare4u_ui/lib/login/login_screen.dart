import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/login/bloc/bloc.dart';
import 'package:icare4u_ui/login/login_form.dart';
import 'package:icare4u_ui/repositories/user_repository.dart';
import 'package:icare4u_ui/screens/home/welcome.dart';
import 'package:icare4u_ui/service_locator.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getSystemUiOverlayStyle,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
          backgroundColor: Colors.white,
          body: BlocProvider<LoginBloc>(
            create: (context) =>
                LoginBloc(userRepository: locator<UserRepository>()),
            child: LoginForm(userRepository: locator<UserRepository>()),
          ),
        ),
      ),
    );
  }
}
