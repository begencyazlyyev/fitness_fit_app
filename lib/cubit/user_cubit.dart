import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/models/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(users: [], draftUser: null));

  // Called on CreateAccount page
  void setCredentials({required String email, required String password}) {
    final draft = UserModel(
      name: '',
      surname: '',
      email: email,
      password: password,
      dateOfBirth: '',
    );
    emit(state.copyWith(draftUser: draft));
  }

  // Called on UserDetailsPage
  void setDetails({
    required String name,
    required String surname,
    required String dateOfBirth,
    String? gender,
    String? phone,
    String? imagePath,
  }) {
    final updated = state.draftUser!.copyWith(
      name: name,
      surname: surname,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phone: phone,
      imagePath: imagePath,
    );
    emit(state.copyWith(draftUser: updated));
  }

  // Called on ChooseGenderPage — finalizes and saves the user
  void finalizeUser({required String workoutGender}) {
    final completed = state.draftUser!.copyWith(workoutGender: workoutGender);
    final updatedUsers = List<UserModel>.from(state.users)..add(completed);
    emit(state.copyWith(users: updatedUsers, draftUser: null));
  }

  void updateUser({
    String? name,
    String? surname,
    String? dateOfBirth,
    String? gender,
    String? phone,
    String? imagePath,
  }) {
    if (state.users.isEmpty) return;

    final updatedUser = state.users.last.copyWith(
      name: name,
      surname: surname,
      dateOfBirth: dateOfBirth,
      gender: gender,
      phone: phone,
      imagePath: imagePath,
    );

    final updatedUsers = List<UserModel>.from(state.users)
      ..[state.users.length - 1] = updatedUser;

    emit(state.copyWith(users: updatedUsers));
  }
}
