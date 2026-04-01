// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String surname;
  final String dateOfBirth;
  final String? imagePath;
  UserModel({
    required this.name,
    required this.surname,
    required this.dateOfBirth,
    this.imagePath,
  });

  UserModel copyWith({
    String? name,
    String? surname,
    String? dateOfBirth,
    String? imagePath,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
