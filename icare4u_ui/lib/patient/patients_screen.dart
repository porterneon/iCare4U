import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icare4u_ui/patient/bloc/patient_list_bloc.dart';
import 'package:icare4u_ui/patient/patient_list.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

class PatientsScreen extends StatelessWidget {
  final PatientDetailsRepository _patientDetailsRepository;
  final String _userId;

  const PatientsScreen({
    Key key,
    @required PatientDetailsRepository patientDetailsRepository,
    String userId,
  })  : assert(patientDetailsRepository != null),
        _patientDetailsRepository = patientDetailsRepository,
        _userId = userId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientListBloc>(
      create: (context) =>
          PatientListBloc(repository: _patientDetailsRepository),
      child: PatientList(
        userId: _userId,
      ),
    );
  }
}
