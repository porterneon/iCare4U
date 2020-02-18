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
  final String groupId;
  final String userId;

  const FetchPatientDetails({
    @required this.userId,
    @required this.patientId,
    @required this.groupId,
  })  : assert(userId != null),
        assert(patientId != null),
        assert(groupId != null);

  @override
  List<Object> get props => [patientId, groupId];
}
