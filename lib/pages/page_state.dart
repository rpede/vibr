import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../models/track.dart';
import '../pages/pages.dart';

class PageState extends Equatable {
  final int index;

  AppPage get current => pages[index];

  const PageState._({
    required this.index,
  });

  PageState.initial() : index = 0;

  PageState copyWith({
    int? pageIndex,
  }) {
    return PageState._(
      index: pageIndex ?? this.index,
    );
  }

  @override
  List<Object?> get props => [index];
}
