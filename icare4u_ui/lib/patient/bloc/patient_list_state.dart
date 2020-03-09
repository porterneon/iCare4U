part of 'patient_list_bloc.dart';

abstract class PatientListState extends Equatable {
  const PatientListState();

  @override
  List<Object> get props => [];
}

class PatientCollectionEmpty extends PatientListState {}

class PatientCollectionLoading extends PatientListState {}

class PatientCollectionLoaded extends PatientListState {
  final List<Patient> patients;

  const PatientCollectionLoaded({
    @required this.patients,
  }) : assert(patients != null);

  @override
  List<Object> get props => [patients];
}

class PatientCollectionError extends PatientListState {
  final String error;

  PatientCollectionError({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];
}
