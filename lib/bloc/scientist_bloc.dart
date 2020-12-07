import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
        yield ScientistDeletedState();
        scientistListBloc.add(ScientistListLoadEvent());
      } catch (e) {
        yield ScientistDeleteFailedState();
      }
    }
  }
}
