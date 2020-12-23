part of 'randomscientist_bloc.dart';

abstract class RandomScientistState extends Equatable {
  const RandomScientistState();
}

class RandomscientistInitial extends RandomScientistState {
  @override
  List<Object> get props => [];
}

class RandomScientistsLoadingState extends RandomScientistState {
  @override
  List<Object> get props => [];
}

class RandomScientistsLoadedState extends RandomScientistState {
  final Scientist scientist;

  RandomScientistsLoadedState({this.scientist});
  @override
  List<Object> get props => [scientist];
}

class RandomScientistsLoadFailedState extends RandomScientistState {
  @override
  List<Object> get props => [];
}
