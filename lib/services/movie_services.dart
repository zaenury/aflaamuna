part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getPopularityMovies(int page) async {
    var respon = await http
        .get(Uri.parse(baseUrl + apiParam + apiKey + sortBy + popularity));

    if (respon.statusCode != 200) {
      return [];
    }
    var data = json.decode(respon.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<List<Movie>> getReleaseDateMovies(int page) async {
    var respon = await http
        .get(Uri.parse(baseUrl + apiParam + apiKey + sortBy + releaseData));

    if (respon.statusCode != 200) {
      return [];
    }
    var data = json.decode(respon.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<List<Movie>> getVoteCountMovies(int page) async {
    var respon = await http
        .get(Uri.parse(baseUrl + apiParam + apiKey + sortBy + voteCount));

    if (respon.statusCode != 200) {
      return [];
    }
    var data = json.decode(respon.body);
    List result = data['results'];

    return result.map((e) => Movie.fromJson(e)).toList();
  }

  static Future<MovieDetail> getDetails(Movie movie, {int movieID}) async {
    var respon = await http.get(
        Uri.parse(movieDetail + "${movieID ?? movie.id}" + apiParam + apiKey));

    var data = json.decode(respon.body);

    String backdrop = (data as Map<String, dynamic>)['backdrop_path'];
    String releaseDate = (data as Map<String, dynamic>)['release_date'];
    String homePage = (data as Map<String, dynamic>)['homepage'];
    int runtime = (data as Map<String, dynamic>)['runtime'];
    int revenue = (data as Map<String, dynamic>)['revenue'];
    double voteAverage = (data as Map<String, dynamic>)['vote_average'];
    int voteCount = (data as Map<String, dynamic>)['vote_count'];
    String language = (data as Map<String, dynamic>)['original_language'];
    List productionCompanies =
        (data as Map<String, dynamic>)['production_companies'];
    List spokenLanguages = (data as Map<String, dynamic>)['spoken_languages'];
    List genres = (data as Map<String, dynamic>)['genres'];

    switch ((data as Map<String, dynamic>)['original_language'].toString()) {
      case 'ja':
        language = "Japanese";
        break;
      case 'id':
        language = "Indonesian";
        break;
      case 'ko':
        language = "Korean";
        break;
      case 'en':
        language = "English";
        break;
    }

    var hasilakhir = MovieDetail(movie,
        backdrop: backdrop,
        releaseDate: releaseDate,
        homePage: homePage,
        runtime: runtime,
        revenue: revenue,
        voteAverage: voteAverage,
        voteCount: voteCount,
        language: language,
        productionCompanies: productionCompanies
            .map((e) => (e as Map<String, dynamic>)['name'].toString())
            .toList(),
        spokenLanguages: spokenLanguages
            .map((e) => (e as Map<String, dynamic>)['english_name'].toString())
            .toList(),
        genres: genres
            .map((e) => (e as Map<String, dynamic>)['name'].toString())
            .toList());

    return hasilakhir;
  }
}
