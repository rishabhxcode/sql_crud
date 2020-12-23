part of 'randomscientist_bloc.dart';

abstract class RandomScientistEvent extends Equatable {
  const RandomScientistEvent();
  @override
  List<Object> get props => [];
}

class RandomScientistsLoadEvent extends RandomScientistEvent {
}

class LoadNextScientistEvent extends RandomScientistEvent {
}

