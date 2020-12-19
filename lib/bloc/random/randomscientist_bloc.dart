import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../database_helper.dart';
import '../../model.dart';

part 'randomscientist_event.dart';
part 'randomscientist_state.dart';

class RandomScientistBloc
    extends Bloc<RandomScientistEvent, RandomScientistState> {
  RandomScientistBloc() : super(RandomscientistInitial());
  DatabaseHelper helper = DatabaseHelper();

  @override
  Stream<RandomScientistState> mapEventToState(
    RandomScientistEvent event,
  ) async* {
    try {
      if (event is RandomScientistLoadEvent) {
        yield RandomScientistLoadingState();
        var scientist = await helper.getScientist();
        yield RandomScientistLoadedState(scientist: scientist);
      }
    } catch (e) {
      yield RandomScientistLoadFailedState();
    }
  }
}
