import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/register/bloc/bloc.dart';
import 'package:icare4u_ui/register/register_form.dart';
import 'package:icare4u_ui/repositories/repositories.dart';
import 'package:icare4u_ui/screens/home/welcome_screen.dart';
import 'package:icare4u_ui/utilities/constants.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getSystemUiOverlayStyle,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Register'),
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
          body: Center(
            child: BlocProvider<RegisterBloc>(
              create: (context) =>
                  RegisterBloc(userRepository: _userRepository),
              child: RegisterForm(),
            ),
          ),
        ),
      ),
    );
  }
}
