import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sql_crud/model.dart';

import '../../database_helper.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ScientistListingBloc
    extends Bloc<ScientistListingEvent, ScientistListingState> {
  ScientistListingBloc() : super(ListingBlocInitial());
  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<ScientistListingState> mapEventToState(
    ScientistListingEvent event,
  ) async* {
    helper
        .initializeDatabase()
        .then((value) => {print('DATABASE INITIALIZED')});
    if (event is ScientistListLoadEvent) {
      try {
        yield ScientistListLoadingState();
        var scientists = await helper.getScientists();
        yield ScientistListLoadedState(scientists: scientists);
      } catch (e) {
        yield ScientistListLoadFailedState();
      }
    }
  }
}
