part of 'listing_bloc.dart';

abstract class ScientistListingEvent extends Equatable {
  const ScientistListingEvent();
}

class ScientistListLoadEvent extends ScientistListingEvent {
  @override
  List<Object> get props => [];
}
