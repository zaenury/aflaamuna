part of 'models.dart';

class Movie extends Equatable {
  final int id;
  final String title, overview, posterPath;
  final double popularity;

  Movie({this.id, this.title, this.overview, this.popularity, this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        popularity: (json['popularity'] as num)
            .toDouble(), //biar gak dianggap int kalau value tidak ada koma
        posterPath: json['poster_path'],
      );

  @override
  List<Object> get props => [id, title, overview, popularity, posterPath];
}
