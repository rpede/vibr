import 'dart:collection';

import 'package:bloc/bloc.dart';

import '../datasources/isar_datasource.dart';
import '../models/models.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final IsarDataSource _db;
  SearchCubit(this._db) : super(SearchState.initial());

  load() async {
    emit(state.copyWith(status: SearchStatus.loading));
    final genres = await _db.getGenres();
    final previous = await _db.getLastSearches(10);
    emit(state.copyWith(
      status: SearchStatus.ready,
      genres: UnmodifiableListView(genres),
      previous: UnmodifiableListView(previous),
    ));
  }

  toggleGenre(String genre) {
    if (state.selectedGenres.contains(genre)) {
      emit(state.copyWith(
        selectedGenres: UnmodifiableSetView(
            state.selectedGenres.where((e) => e != genre).toSet()),
      ));
    } else {
      emit(state.copyWith(
        selectedGenres: UnmodifiableSetView({...state.selectedGenres, genre}),
      ));
    }
  }

  search(String term) async {
    emit(state.copyWith(status: SearchStatus.searching));
    final search = Search.create(term);
    await _db.saveSearch(search);
    final genres =
        state.selectedGenres.isNotEmpty ? state.selectedGenres : null;
    final results = await _db.searchForTracks(term, genres: genres);
    final previous = [search, ...state.previous.take(9)];
    emit(
      state.copyWith(
          status: SearchStatus.ready,
          previous: UnmodifiableListView(previous),
          results: UnmodifiableListView(results)),
    );
  }

  remove(Search search) async {
    await _db.removeSearch(search.id);
    final previous = await _db.getLastSearches(10);
    emit(state.copyWith(previous: UnmodifiableListView(previous)));
  }
}
