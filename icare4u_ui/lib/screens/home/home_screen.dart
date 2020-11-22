import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icare4u_ui/patient/patients_screen.dart';
import 'package:icare4u_ui/repositories/repositories.dart';
import 'package:icare4u_ui/screens/components/app_drawer.dart';
import 'package:icare4u_ui/constants.dart';
import 'package:icare4u_ui/service_locator.dart';

class Home extends StatelessWidget {
  final String _userId;

  const Home({
    Key key,
    String userId,
  })  : _userId = userId,
        super(key: key);

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
        child: Container(
          decoration: globalGradientDecorationStyle,
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PatientsScreen(
                    patientDetailsRepository:
                        locator<PatientDetailsRepository>(),
                    userId: _userId,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
