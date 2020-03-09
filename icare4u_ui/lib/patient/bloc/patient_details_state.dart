part of 'patient_details_bloc.dart';

abstract class PatientDetailsState extends Equatable {
  const PatientDetailsState();

  @override
  List<Object> get props => [];
}

class PatientDetailsEmpty extends PatientDetailsState {}

class PatientDetailsLoading extends PatientDetailsState {}

class PatientDetailsLoaded extends PatientDetailsState {
  final Patient patient;

  const PatientDetailsLoaded({
    @required this.patient,
  }) : assert(patient != null);

  @override
  List<Object> get props => [patient];
}

class PatientDetailsError extends PatientDetailsState {
  final String error;

  PatientDetailsError({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];
}
