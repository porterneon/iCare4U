import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'schedules_event.dart';
part 'schedules_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc() : super(SchedulesInitial());

  @override
  Stream<SchedulesState> mapEventToState(
    SchedulesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
