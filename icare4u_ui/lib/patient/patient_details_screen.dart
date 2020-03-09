import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/patient/bloc/patient_details_bloc.dart';

class PatientDetailsScreen extends StatefulWidget {
  final String patientId;

  const PatientDetailsScreen({
    Key key,
    @required this.patientId,
  }) : super(key: key);

  @override
  PatientDetailsScreenState createState() {
    return PatientDetailsScreenState();
  }
}

class PatientDetailsScreenState extends State<PatientDetailsScreen> {
  PatientDetailsBloc _patientDetailsBloc;

  @override
  void initState() {
    super.initState();
    _patientDetailsBloc = BlocProvider.of<PatientDetailsBloc>(context);
    this._load();
  }

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

          if ((state is PatientDetailsEmpty || state is PatientDetailsEmpty) &&
              widget.patientId != null) {
            _patientDetailsBloc.add(FetchPatientDetails(
              patientId: widget.patientId,
            ));
          }

          if (state is PatientDetailsLoading) {
            debugPrint('loading patient details');
          }

          if (state is PatientDetailsLoaded) {
            debugPrint("patient details loaded");
          }
        },
        child: BlocBuilder<PatientDetailsBloc, PatientDetailsState>(
            bloc: _patientDetailsBloc,
            builder: (
              BuildContext context,
              PatientDetailsState currentState,
            ) {
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
                      Text(currentState.patient.name),
                      Text(currentState.patient.patientId),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  void _load() {
    _patientDetailsBloc.add(
      FetchPatientDetails(
        patientId: widget.patientId,
      ),
    );
  }
}
