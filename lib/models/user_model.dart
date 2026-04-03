// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String surname;
  final String email;
  final String password;
  final String dateOfBirth;
  final String? gender;
  final String? phone;
  final String? imagePath;
  final String? workoutGender; // from ChooseGenderPage

  UserModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    this.gender,
    this.phone,
    this.imagePath,
    this.workoutGender,
  });

  UserModel copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? dateOfBirth,
    String? gender,
    String? phone,
    String? imagePath,
    String? workoutGender,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
      workoutGender: workoutGender ?? this.workoutGender,
    );
  }
}
