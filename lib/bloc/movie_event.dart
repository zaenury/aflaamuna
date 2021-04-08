part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();
}

class FetchMoviesPopularity extends MovieEvent {
  List<Object> get props => [];
}

class FetchMoviesReleaseDate extends MovieEvent {
  List<Object> get props => [];
}

class FetchMoviesVoteCount extends MovieEvent {
  List<Object> get props => [];
}
