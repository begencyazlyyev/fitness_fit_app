// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/models/user_model.dart';

class UserState {
  final List<UserModel> users;
  final UserModel? draftUser;

  UserState({required this.users, this.draftUser});

  UserState copyWith({List<UserModel>? users, UserModel? draftUser}) {
    return UserState(
      users: users ?? this.users,
      draftUser: draftUser ?? this.draftUser,
    );
  }
}
