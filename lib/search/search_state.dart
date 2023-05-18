import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../models/models.dart';

enum SearchStatus {
  initial,
  loading,
  searching,
  ready,
}

class SearchState extends Equatable {
  final SearchStatus status;
  final UnmodifiableListView<String> genres;
  final UnmodifiableSetView<String> selectedGenres;
  final UnmodifiableListView<Search> previous;
  final UnmodifiableListView<Track> results;

  const SearchState({
    required this.status,
    required this.genres,
    required this.selectedGenres,
    required this.previous,
    required this.results,
  });

  SearchState.initial()
      : status = SearchStatus.initial,
        genres = UnmodifiableListView([]),
        selectedGenres = UnmodifiableSetView(<String>{}),
        previous = UnmodifiableListView([]),
        results = UnmodifiableListView([]);

  SearchState copyWith({
    SearchStatus? status,
    UnmodifiableListView<String>? genres,
    UnmodifiableSetView<String>? selectedGenres,
    UnmodifiableListView<Search>? previous,
    UnmodifiableListView<Track>? results,
  }) {
    return SearchState(
        status: status ?? this.status,
        genres: genres ?? this.genres,
        selectedGenres: selectedGenres ?? this.selectedGenres,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }

  @override
  List<Object?> get props => [status, genres, selectedGenres, previous, results];
}
