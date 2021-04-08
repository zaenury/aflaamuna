part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnPageInitial extends PageState {
  @override
  List<Object> get props => [];
}

class OnMainPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnMovieDetailPage extends PageState {
  final Movie movie;

  OnMovieDetailPage(this.movie);

  @override
  List<Object> get props => [movie];
}
