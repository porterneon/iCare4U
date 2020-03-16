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
            bloc: patientDetailsBloc,
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text("Patient name:"),
                                  SizedBox(width: 10.0),
                                  Text(currentState.patient.name),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text("Birth date:"),
                                  SizedBox(width: 10.0),
                                  Text(currentState.patient.birthDate),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Text(currentState.patient.patientId),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text("Wiek:"),
                              SizedBox(width: 10.0),
                              Text(currentState.patient.age),
                              SizedBox(width: 5.0),
                              Text("years."),
                            ],
                          ),
                        ),
                      ),
                    ],
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

  void _load() {
    patientDetailsBloc.add(
      FetchPatientDetails(
        patientId: patientId,
      ),
    );
  }
}
