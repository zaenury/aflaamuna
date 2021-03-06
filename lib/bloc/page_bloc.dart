import 'dart:async';

import 'package:aflaamuna/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnPageInitial());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToMainPage) {
      yield OnMainPage();
    } else if (event is GoToMovieDetailPage) {
      yield OnMovieDetailPage(event.movie);
    }
  }
}
