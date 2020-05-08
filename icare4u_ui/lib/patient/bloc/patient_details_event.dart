part of 'patient_details_bloc.dart';

abstract class PatientDetailsEvent extends Equatable {
  const PatientDetailsEvent();
}

class FetchPatientCollection extends PatientDetailsEvent {
  final String userId;

  const FetchPatientCollection({@required this.userId})
      : assert(userId != null);

  @override
  List<Object> get props => [userId];
}

class FetchPatientDetails extends PatientDetailsEvent {
  final String patientId;

  const FetchPatientDetails({
    @required this.patientId,
  }) : assert(patientId != null);

  @override
  List<Object> get props => [patientId];
}

class GetCachedPatientDetails extends PatientDetailsEvent {
  final String patientId;

  const GetCachedPatientDetails({
    @required this.patientId,
  }) : assert(patientId != null);

  @override
  List<Object> get props => [patientId];
}
