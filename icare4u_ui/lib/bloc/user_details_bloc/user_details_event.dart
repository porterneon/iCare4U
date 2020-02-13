part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();
}

class FetchUserDetails extends UserDetailsEvent {
  final String userId;

  const FetchUserDetails({@required this.userId}) : assert(userId != null);

  @override
  List<Object> get props => [userId];
}
