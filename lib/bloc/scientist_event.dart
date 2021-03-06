part of 'scientist_bloc.dart';

abstract class ScientistEvent extends Equatable {
  const ScientistEvent();
   @override
  List<Object> get props => [];
}

class ScientistAddEvent extends ScientistEvent {
  final Scientist scientist;

  ScientistAddEvent({this.scientist});

  @override
  List<Object> get props => [scientist];
}

class ScientistDeleteEvent extends ScientistEvent {
  final int id;
  ScientistDeleteEvent({this.id});

  @override
  List<Object> get props => [id];
}


class ScientistBulkAddEvent extends ScientistEvent {
}

