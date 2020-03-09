part of 'patient_list_bloc.dart';

abstract class PatientListEvent extends Equatable {
  const PatientListEvent();
}

class FetchPatientCollection extends PatientListEvent {
  final String userId;

  const FetchPatientCollection({@required this.userId})
      : assert(userId != null);

  @override
  List<Object> get props => [userId];
}

class FetchPatientDetails extends PatientListEvent {
  final String patientId;

  const FetchPatientDetails({
    @required this.patientId,
  }) : assert(patientId != null);

  @override
  List<Object> get props => [patientId];
}
