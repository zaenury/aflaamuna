part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToMainPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;

  GoToMovieDetailPage(this.movie);
  @override
  List<Object> get props => [movie];
}
