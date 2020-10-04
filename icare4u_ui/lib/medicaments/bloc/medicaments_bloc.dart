import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'medicaments_event.dart';
part 'medicaments_state.dart';

class MedicamentsBloc extends Bloc<MedicamentsEvent, MedicamentsState> {
  MedicamentsBloc() : super(MedicamentsInitial());

  @override
  Stream<MedicamentsState> mapEventToState(
    MedicamentsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
