import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

part 'medicaments_event.dart';
part 'medicaments_state.dart';

class MedicamentsBloc extends Bloc<MedicamentsEvent, MedicamentsState> {
  final MedicamentsRepository repository;

  MedicamentsBloc({@required this.repository})
      : assert(repository != null),
        super(MedicamentsInitial());

  @override
  Stream<MedicamentsState> mapEventToState(
    MedicamentsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
