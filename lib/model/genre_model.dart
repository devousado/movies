// ignore_for_file: public_member_api_docs, sort_constructors_first

class GenreModel {
  int id;
  String genre;
  GenreModel({
    required this.id,
    required this.genre,
  });

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'] as int,
      genre: map['name'] as String,
    );
  }

  @override
  String toString() => 'GenreModel(id: $id, genre: $genre)';
}
