part of 'scientist_bloc.dart';

abstract class ScientistState extends Equatable {
  const ScientistState();
}

class ScientistInitial extends ScientistState {
  const ScientistInitial();

  @override
  List<Object> get props => [];
}

//List Load


// Add
class ScientistAddingState extends ScientistState {
  @override
  List<Object> get props => [];
}

class ScientistAddedState extends ScientistState {
  @override
  List<Object> get props => [];
}

class ScientistAddFailedState extends ScientistState {
  @override
  List<Object> get props => [];
}

//Delete
class ScientistDeletedState extends ScientistState {
  @override
  List<Object> get props => [];
}

class ScientistDeletingState extends ScientistState {
  @override
  List<Object> get props => [];
}

class ScientistDeleteFailedState extends ScientistState {
  @override
  List<Object> get props => [];
}
