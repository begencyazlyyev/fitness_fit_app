import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/components/birthday_widget.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/gender_widget.dart';
import 'package:flutter_application_1/components/phone_field_widget.dart';
import 'package:flutter_application_1/components/text_field_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/models/user_state.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  File? selectedImage;
  String? selectedGender;
  DateTime? selectedDate;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-fill fields with existing user data only once
    if (!_initialized) {
      final user = context.read<UserCubit>().state.users.isNotEmpty
          ? context.read<UserCubit>().state.users.last
          : null;
      if (user != null) {
        name.text = user.name;
        surname.text = user.surname;
        phone.text = user.phone ?? '';
        selectedGender = user.gender;
        selectedDate = user.dateOfBirth.isNotEmpty
            ? DateTime.tryParse(user.dateOfBirth)
            : null;
        selectedImage = user.imagePath != null ? File(user.imagePath!) : null;
      }
      _initialized = true;
    }
  }

  @override
  void dispose() {
    name.dispose();
    surname.dispose();
    phone.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile", style: KTextStyle.titleStyle)),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Gap(20),

                // Profile picture picker
                Center(
                  child: InkWell(
                    onTap: _pickImage,
                    child: Stack(
                      children: [
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: selectedImage != null
                                ? Image.file(selectedImage!, fit: BoxFit.cover)
                                : const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        // Edit icon badge
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(30),

                TextFieldWidget(
                  labelText: "Name",
                  icons: null,
                  controller: name,
                ),
                const Gap(30),
                TextFieldWidget(
                  labelText: "Surname",
                  icons: null,
                  controller: surname,
                ),
                const Gap(30),
                GenderDropdownWidget(
                  value: selectedGender,
                  onChanged: (val) => setState(() => selectedGender = val),
                ),
                const Gap(30),
                DateOfBirthWidget(
                  value: selectedDate,
                  onChanged: (val) => setState(() => selectedDate = val),
                ),
                const Gap(30),
                PhoneFieldWidget(
                  labelText: "Phone Number",
                  hintText: "XX XXX XXX",
                  controller: phone,
                ),
                const Gap(30),

                ButtonWidget(
                  label: "Save Changes",
                  onPressed: () {
                    context.read<UserCubit>().updateUser(
                      // ← was setDetails
                      name: name.text.trim(),
                      surname: surname.text.trim(),
                      dateOfBirth: selectedDate?.toIso8601String() ?? '',
                      gender: selectedGender,
                      phone: phone.text.trim(),
                      imagePath: selectedImage?.path,
                    );
                    Navigator.of(context).pop();
                  },
                ),
                const Gap(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
