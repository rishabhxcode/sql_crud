part of 'randomscientist_bloc.dart';

abstract class RandomScientistEvent extends Equatable {
  const RandomScientistEvent();
}

class RandomScientistLoadEvent extends RandomScientistEvent {
  @override
  List<Object> get props => [];
}
