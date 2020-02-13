part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}

class UserDetailsEmpty extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsLoaded extends UserDetailsState {
  final UserDetails userDetails;

  const UserDetailsLoaded({@required this.userDetails})
      : assert(userDetails != null);

  @override
  List<Object> get props => [userDetails];
}

class UserDetailsError extends UserDetailsState {}
