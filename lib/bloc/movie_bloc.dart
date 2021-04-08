import 'dart:async';

import 'package:aflaamuna/models/models.dart';
import 'package:aflaamuna/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MoviePopularityBloc extends Bloc<MovieEvent, MovieState> {
  MoviePopularityBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    //stream: aliran data
    MovieEvent event,
  ) async* {
    if (event is FetchMoviesPopularity) {
      List<Movie> moviesPopularity = await MovieServices.getPopularityMovies(1);

      //yield: perintah untuk memasukkan data ke dalam stream
      yield MovieLoadedPopularity(movies: moviesPopularity);
    }
  }
}

class MovieReleaseDateBloc extends Bloc<MovieEvent, MovieState> {
  MovieReleaseDateBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMoviesReleaseDate) {
      List<Movie> moviesReleaseDate =
          await MovieServices.getReleaseDateMovies(1);
      yield MovieLoadedReleaseDate(movies: moviesReleaseDate);
    }
  }
}

class MovieVoteCountBloc extends Bloc<MovieEvent, MovieState> {
  MovieVoteCountBloc() : super(MovieInitial());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is FetchMoviesVoteCount) {
      List<Movie> moviesVoteCount = await MovieServices.getVoteCountMovies(1);
      yield MovieLoadedVoteCount(movies: moviesVoteCount);
    }
  }
}
