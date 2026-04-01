// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_application_1/models/user_model.dart';

class UserState {
  final List<UserModel> users;
  UserState({required this.users});

  UserState copyWith({List<UserModel>? users}) {
    return UserState(users: users ?? this.users);
  }
}
