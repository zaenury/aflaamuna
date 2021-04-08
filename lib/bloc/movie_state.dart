part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {
  List<Movie> get props => [];
}

class MovieLoadedPopularity extends MovieState {
  final List<Movie> movies;

  MovieLoadedPopularity({this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieLoadedReleaseDate extends MovieState {
  final List<Movie> movies;

  MovieLoadedReleaseDate({this.movies});

  @override
  List<Object> get props => [movies];
}

class MovieLoadedVoteCount extends MovieState {
  final List<Movie> movies;

  MovieLoadedVoteCount({this.movies});

  @override
  List<Object> get props => [movies];
}
