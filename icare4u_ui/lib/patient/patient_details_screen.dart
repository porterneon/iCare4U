import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/patient/bloc/patient_details_bloc.dart';

class PatientDetailsScreen extends StatefulWidget {
  final String patientId;

  const PatientDetailsScreen({
    Key key,
    @required PatientDetailsBloc patientDetailsBloc,
    @required this.patientId,
  })  : _patientDetailsBloc = patientDetailsBloc,
        super(key: key);

  final PatientDetailsBloc _patientDetailsBloc;

  @override
  PatientDetailsScreenState createState() {
    return PatientDetailsScreenState();
  }
}

class PatientDetailsScreenState extends State<PatientDetailsScreen> {
  PatientDetailsScreenState();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
          bloc: widget._patientDetailsBloc,
          builder: (
            BuildContext context,
            PatientDetailsState currentState,
          ) {
            if (currentState is PatientDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is PatientDetailsError) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.error ?? 'Error'),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text('reload'),
                      onPressed: () => this._load(),
                    ),
                  ),
                ],
              ));
            }
            if (currentState is PatientDetailsLoaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(currentState.patient.name),
                    Text('Flutter files: done'),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  void _load() {
    widget._patientDetailsBloc.add(FetchPatientDetails(
      patientId: widget.patientId,
    ));
  }
}
