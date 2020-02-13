import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:icare4u_ui/models/models.dart';
import 'package:icare4u_ui/repositories/repositories.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final UserDetailsRepository userDetailsRepository;

  UserDetailsBloc({@required this.userDetailsRepository})
      : assert(userDetailsRepository != null);

  @override
  UserDetailsState get initialState => UserDetailsEmpty();

  @override
  Stream<UserDetailsState> mapEventToState(
    UserDetailsEvent event,
  ) async* {
    if (event is FetchUserDetails) {
      yield UserDetailsLoading();
      try {
        final UserDetails userDetails =
            await userDetailsRepository.getUserDetals(event.userId);
        yield UserDetailsLoaded(userDetails: userDetails);
      } catch (_) {
        yield UserDetailsError();
      }
    }
  }
}
