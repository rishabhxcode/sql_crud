part of 'randomscientist_bloc.dart';

abstract class RandomScientistState extends Equatable {
  const RandomScientistState();
}

class RandomscientistInitial extends RandomScientistState {
  @override
  List<Object> get props => [];
}

class RandomScientistLoadingState extends RandomScientistState {
  @override
  List<Object> get props => [];
}

class RandomScientistLoadedState extends RandomScientistState {
  final Scientist scientist;

  RandomScientistLoadedState({this.scientist});
  @override
  List<Object> get props => [scientist];
}

class RandomScientistLoadFailedState extends RandomScientistState {
  @override
  List<Object> get props => [];
}
