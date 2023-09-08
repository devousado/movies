// ignore_for_file: public_member_api_docs, sort_constructors_first
class CastModel {
  int id;
  String name;
  String? profilepath;
  CastModel({
    required this.id,
    required this.name,
    required this.profilepath,
  });

  factory CastModel.fromMap(Map<String, dynamic> map) {
    return CastModel(
      id: map['id'] as int,
      name: map['name'],
      profilepath: map['profile_path'],
    );
  }

  @override
  String toString() =>
      'CastModel(id: $id, name: $name, profilepath: $profilepath)';
}
