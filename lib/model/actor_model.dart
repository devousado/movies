// ignore_for_file: public_member_api_docs, sort_constructors_first
class ActorModel {
  int id;
  String name;
  String image;
  ActorModel({
    required this.id,
    required this.name,
    required this.image,
  });
  factory ActorModel.fromMap(Map<String, dynamic> map) {
    return ActorModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['profile_path'] as String,
    );
  }
}
