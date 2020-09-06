import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

part 'patient_list_event.dart';
part 'patient_list_state.dart';

class PatientListBloc extends Bloc<PatientListEvent, PatientListState> {
  final PatientDetailsRepository repository;

  PatientListBloc({@required this.repository})
      : assert(repository != null),
        super(PatientCollectionEmpty());

  @override
  Stream<PatientListState> mapEventToState(
    PatientListEvent event,
  ) async* {
    if (event is FetchPatientCollection) {
      yield PatientCollectionLoading();
      try {
        final List<Patient> patientCollection =
            await repository.fetchPatientCollection(event.userId);

        yield PatientCollectionLoaded(patients: patientCollection);
      } catch (e) {
        debugPrint(e);
        yield PatientCollectionError(error: e);
      }
    }

    if (event is GetCachedPatientCollection) {
      yield PatientCollectionLoading();
      try {
        List<Patient> patientCollection =
            await repository.getPatientCollection();

        if (patientCollection == null || patientCollection.isEmpty) {
          patientCollection =
              await repository.fetchPatientCollection(event.userId);
        }

        yield PatientCollectionLoaded(patients: patientCollection);
      } catch (e) {
        debugPrint(e);
        yield PatientCollectionError(error: e);
      }
    }
  }
}
