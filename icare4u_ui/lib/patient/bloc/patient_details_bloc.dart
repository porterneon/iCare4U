import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

part 'patient_details_event.dart';
part 'patient_details_state.dart';

class PatientDetailsBloc
    extends Bloc<PatientDetailsEvent, PatientDetailsState> {
  final PatientDetailsRepository repository;

  PatientDetailsBloc({@required this.repository})
      : assert(repository != null),
        super(PatientDetailsEmpty());

  @override
  Stream<PatientDetailsState> mapEventToState(
    PatientDetailsEvent event,
  ) async* {
    if (event is FetchPatientDetails) {
      yield PatientDetailsLoading();
      try {
        final Patient patient =
            await repository.fetchPatientDetials(event.patientId);
        yield PatientDetailsLoaded(patient: patient);
      } catch (e) {
        yield PatientDetailsError(error: e);
      }
    }

    if (event is GetCachedPatientDetails) {
      yield PatientDetailsLoading();
      try {
        final Patient patient =
            await repository.getCachedPatientDetials(event.patientId);
        yield PatientDetailsLoaded(patient: patient);
      } catch (e) {
        yield PatientDetailsError(error: e);
      }
    }
  }
}
