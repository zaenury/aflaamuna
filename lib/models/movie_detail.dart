part of 'models.dart';

class MovieDetail extends Movie {
  final String backdrop, releaseDate, homePage, language;
  final List<String> productionCompanies, spokenLanguages, genres;
  final int runtime, revenue, voteCount;
  final double voteAverage;

  MovieDetail(Movie movie,
      {this.backdrop,
      this.releaseDate,
      this.homePage,
      this.productionCompanies,
      this.runtime,
      this.revenue,
      this.voteAverage,
      this.voteCount,
      this.spokenLanguages,
      this.language,
      this.genres})
      //constructor parent (Movie)
      : super(
            id: movie.id,
            title: movie.title,
            overview: movie.overview,
            popularity: movie.popularity,
            posterPath: movie.posterPath);

  String get allProductionCompanies {
    String all = "";

    for (var productionCompany in productionCompanies) {
      all += productionCompany +
          (productionCompany != productionCompanies.last ? ', ' : '');
    }

    return "$all";
  }

  String get allSpokenlanguages {
    String all = "";

    for (var spokenLanguage in spokenLanguages) {
      all +=
          spokenLanguage + (spokenLanguage != spokenLanguages.last ? "," : "");
    }
    return "$all";
  }

  String get allGenres {
    String all = "";

    for (var genre in genres) {
      all += genre + (genre != genres.last ? ', ' : '');
    }

    return "$all";
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  String get changeRunTimeFormat {
    final change = Duration(minutes: runtime);
    return format(change);
  }

  @override
  List<Object> get props => [
        backdrop,
        releaseDate,
        homePage,
        productionCompanies,
        runtime,
        revenue,
        voteAverage,
        voteCount,
        spokenLanguages,
        language,
        genres
      ];
}
