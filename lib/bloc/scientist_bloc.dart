import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sql_crud/bloc/listing_bloc/listing_bloc.dart';
import 'package:sql_crud/model.dart';

import '../database_helper.dart';

part 'scientist_event.dart';
part 'scientist_state.dart';

class ScientistBloc extends Bloc<ScientistEvent, ScientistState> {
  final ScientistListingBloc scientistListBloc;
  ScientistBloc({this.scientistListBloc}) : super(ScientistInitial());
  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<ScientistState> mapEventToState(
    ScientistEvent event,
  ) async* {
    helper
        .initializeDatabase()
        .then((value) => {print('DATABASE INITIALIZED')});

    if (event is ScientistAddEvent) {
      try {
        yield ScientistAddingState();
        await helper.insertScientist(event.scientist);
        // We can optimize it by using a local list and updating that and calling this after the updation of local list...
        // var scientists = await helper.getScientists();
        yield ScientistAddedState();
        scientistListBloc.add(ScientistListLoadEvent());
      } catch (e) {
        yield ScientistAddFailedState();
      }
    }
    if (event is ScientistDeleteEvent) {
      try {
        yield ScientistDeletingState();
        await helper.deleteScientist(event.id);
        // We can optimize it by using a local list and updating that and calling this after the updation of local list...
        var scientists = await helper.getScientists();
        yield ScientistDeletedState();
        scientistListBloc.add(ScientistListUpdateEvent(scientists));
      } catch (e) {
        yield ScientistDeleteFailedState();
      }
    }
    if (event is ScientistBulkAddEvent) {
      if (scientistListBloc.state is ScientistListLoadedState) {
        var scientists = await helper.getScientists();
        if (scientists.length > 50) return;

        for (int i = 0; i < 100; i++) {
          Map<String, dynamic> detail = {
            'name': 'test:$i',
            'known_for': 'something:$i',
            'image_url': ''
          };
          var scientist = Scientist.fromJson(detail);
          var val = await helper.insertScientist(scientist);
          print(val);
        }
        scientistListBloc.add(ScientistListLoadEvent());
      }
    }
  }
}
