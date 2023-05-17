import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';
import '../pages/pages.dart';
import 'page_state.dart';

class PageCubit extends Cubit<PageState> {
  PageCubit() : super(PageState.initial());

  void setPage(AppPage page) {
    final index = pages.asMap().entries.firstWhere((e) => e.value == page).key;
    setIndex(index);
  }

  void setIndex(int index) {
    if (index <= pages.length) {
      navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (context) => pages[index].builder()));
      emit(state.copyWith(pageIndex: index));
    }
  }
}
