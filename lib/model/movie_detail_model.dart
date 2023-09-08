// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieDetailModel {
  String originaltitle;
  bool adult;
  String backdroppath;
  int id;
  String overview;
  String title;
  var voteaverage;
  double popularity;
  String genre;
  int runtime;
  String releasedate;
  MovieDetailModel({
    required this.releasedate,
    required this.originaltitle,
    required this.adult,
    required this.backdroppath,
    required this.id,
    required this.overview,
    required this.title,
    required this.voteaverage,
    required this.popularity,
    required this.genre,
    required this.runtime,
  });

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailModel(
      releasedate: map["release_date"],
      originaltitle: map['original_title'] as String,
      adult: map['adult'] as bool,
      backdroppath: map['backdrop_path'] as String,
      id: map['id'] as int,
      overview: map['overview'] as String,
      title: map['title'] as String,
      voteaverage: map['vote_average'],
      popularity: map['popularity'] as double,
      genre: map['genres'][0]["name"] as String,
      runtime: map['runtime'] as int,
    );
  }

  @override
  String toString() {
    return 'MovieDetailModel(originaltitle: $originaltitle, adult: $adult, backdroppath: $backdroppath, id: $id, overview: $overview, title: $title, voteaverage: $voteaverage, popularity: $popularity, genre: $genre, runtime: $runtime)';
  }
}
