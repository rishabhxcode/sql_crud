part of 'listing_bloc.dart';

abstract class ScientistListingEvent extends Equatable {
  const ScientistListingEvent();
}

class ScientistListLoadEvent extends ScientistListingEvent {
  @override
  List<Object> get props => [];
}

class ScientistListUpdateEvent extends ScientistListingEvent{
   final List<Scientist> scientists;

  ScientistListUpdateEvent(this.scientists);

  @override
  List<Object> get props => [scientists];
}
