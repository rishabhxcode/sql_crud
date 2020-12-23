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
  List<Scientist> scientists = [];
  int index = 0;
  @override
  Stream<RandomScientistState> mapEventToState(
    RandomScientistEvent event,
  ) async* {
    try {
      if (event is RandomScientistsLoadEvent) {
        yield RandomScientistsLoadingState();
        var newScientists = await _loadRandomScientists();
        scientists.addAll(newScientists);
        yield RandomScientistsLoadedState(scientist: scientists[index]);
      }
      if (event is LoadNextScientistEvent) {
        scientists.removeAt(index);
        if (scientists.length <= 4) {
          print("Adding others");
          var newScientists = await _loadRandomScientists();
          scientists.addAll(newScientists);
          yield RandomScientistsLoadedState(scientist: scientists[index]);
        }
        print("Loading next");
        yield RandomScientistsLoadedState(scientist: scientists[index]);
      }
    } catch (e) {
      print(e);
      yield RandomScientistsLoadFailedState();
    }
  }

  Future<List<Scientist>> _loadRandomScientists() async {
   return await helper.getScientist();
  }
}
