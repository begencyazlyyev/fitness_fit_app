import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/models/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(users: []));

  void addUser(UserModel user) {
    final updatedUsers = List<UserModel>.from(state.users)..add(user);
    emit(state.copyWith(users: updatedUsers));
  }
}
