part of 'medicaments_bloc.dart';

abstract class MedicamentsState extends Equatable {
  const MedicamentsState();

  @override
  List<Object> get props => [];
}

class MedicamentsInitial extends MedicamentsState {}

class MedicamentsLoading extends MedicamentsState {}

class MedicamentsLoaded extends MedicamentsState {}

class MedicamentsError extends MedicamentsState {}
