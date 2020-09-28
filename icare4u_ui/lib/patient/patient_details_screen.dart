import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/patient/bloc/patient_details_bloc.dart';

class PatientDetailsScreen extends StatelessWidget {
  final String patientId;
  final PatientDetailsBloc patientDetailsBloc;

  const PatientDetailsScreen({
    Key key,
    @required this.patientId,
    @required this.patientDetailsBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<PatientDetailsBloc, PatientDetailsState>(
        listener: (context, state) {
          if (state is PatientDetailsError) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fetch patient failure'),
                      Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Colors.red,
                ),
              );
          }

          if (state is PatientDetailsLoading) {
            debugPrint('loading patient details');
          }

          if (state is PatientDetailsLoaded) {
            debugPrint("patient details loaded");
          }
        },
        child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
            cubit: patientDetailsBloc,
            builder: (
              BuildContext context,
              PatientDetailsState currentState,
            ) {
              if (currentState is PatientDetailsEmpty && patientId != null) {
                _load();
              }
              if (currentState is PatientDetailsLoading) {
                return Column(
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                );
              }

              if (currentState is PatientDetailsLoaded) {
                // return buildPatiendDetailsView(currentState);
                return SafeArea(
                  child: new Container(
                    margin: new EdgeInsets.fromLTRB(60.0, 16.0, 16.0, 16.0),
                    constraints: new BoxConstraints.expand(),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(height: 4.0),
                        new Text(currentState.patient.name),
                        new Container(height: 10.0),
                        new Text(currentState.patient.patientId),
                        new Container(
                            margin: new EdgeInsets.symmetric(vertical: 8.0),
                            height: 2.0,
                            width: 18.0,
                            color: new Color(0xff00c6ff)),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                                child: _patientValue(
                                    value:
                                        currentState.patient.height.toString() +
                                            " " +
                                            currentState.patient.heightUom,
                                    image: 'assets/img/height.png')),
                            new Expanded(
                                child: _patientValue(
                                    value:
                                        currentState.patient.weight.toString() +
                                            " " +
                                            currentState.patient.weightUom,
                                    image: 'assets/img/weight_machine.png'))
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Container(),
              );
            }),
      ),
    );
  }

  Widget _patientValue({String value, String image}) {
    return new Row(children: <Widget>[
      Image.asset(
        image,
        color: const Color(0xffb6b2df),
        height: 18.0,
      ),
      new Container(width: 8.0),
      new Text(value),
    ]);
  }

  void _load() {
    patientDetailsBloc.add(
      GetCachedPatientDetails(
        patientId: patientId,
      ),
    );
  }

  void _reload() {
    patientDetailsBloc.add(
      FetchPatientDetails(
        patientId: patientId,
      ),
    );
  }
}
