import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Colors,
        Icon,
        RaisedButton,
        RoundedRectangleBorder,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icare4u_ui/login/bloc/bloc.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      icon: Icon(FontAwesomeIcons.google, color: Colors.white),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(
          LoginWithGooglePressed(),
        );
      },
      label: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
      color: Colors.redAccent,
    );
  }
}
