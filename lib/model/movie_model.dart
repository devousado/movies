// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  String originaltitle;
  bool adult;
  String? backdroppath;
  int id;
  String overview;
  String title;
  dynamic voteaverage;
  dynamic popularity;

  String releasedate;
  MovieModel({
    required this.popularity,
    required this.releasedate,
    required this.originaltitle,
    required this.adult,
    this.backdroppath,
    required this.id,
    required this.overview,
    required this.title,
    required this.voteaverage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'original_title': originaltitle,
      'adult': adult,
      'backdrop_path': backdroppath,
      'id': id,
      'overview': overview,
      'title': title,
      'vote_average': voteaverage,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      popularity: map["popularity"],
      originaltitle: map['original_title'] as String,
      adult: map['adult'] as bool,
      backdroppath: map['backdrop_path'],
      id: map['id'],
      overview: map['overview'] as String,
      title: map['title'] as String,
      voteaverage: map['vote_average'],
      releasedate: map["release_date"],
    );
  }

  @override
  String toString() {
    return 'MovieModel(originaltitle: $originaltitle, adult: $adult, backdroppath: $backdroppath, id: $id, overview: $overview, title: $title, voteaverage: $voteaverage)';
  }
}
