part of 'listing_bloc.dart';

abstract class ScientistListingState extends Equatable {
  const ScientistListingState();
}

class ListingBlocInitial extends ScientistListingState {
  @override
  List<Object> get props => [];
}

class ScientistListLoadedState extends ScientistListingState {
  final List<Scientist> scientists;

  ScientistListLoadedState({this.scientists});
 
  @override
  List<Object> get props => [scientists];
}

class ScientistListLoadingState extends ScientistListingState {
  @override
  List<Object> get props => [];
}

class ScientistListLoadFailedState extends ScientistListingState {
  @override
  List<Object> get props => [];
}
