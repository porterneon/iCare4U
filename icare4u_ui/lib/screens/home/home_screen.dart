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
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: new BoxDecoration(
                    color: appBarDecoration.color,
                    borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(30.0)),
                  ),
                  child: Text(
                    "This is temporary text...",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      // fontFamily: 'OpenSans',
                    ),
                  ),
                ),
                Expanded(
                  child: PatientsScreen(
                    patientDetailsRepository:
                        locator<PatientDetailsRepository>(),
                    userId: _userId,
                  ),
                ),
                // RaisedButton(
                //   child: Text('Launch screen'),
                //   onPressed: () {
                //     // Navigate to the second screen using a named route.
                //     Navigator.pushNamed(context, '/second');
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
