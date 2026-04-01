import 'dart:io';
import 'package:flutter_application_1/components/birthday_widget.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/gender_widget.dart';
import 'package:flutter_application_1/components/phone_field_widget.dart';
import 'package:flutter_application_1/components/text_field_widget.dart';
import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController phone = TextEditingController();
  File? selectedImage;
  String? selectedGender;
  DateTime? selectedDate;

  @override
  void dispose() {
    name.dispose();
    surname.dispose();
    dateOfBirth.dispose();
    super.dispose();
  }

  Future<void> addImage() async {
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
      appBar: AppBar(
        title: Text("Fill Your Profile", style: KTextStyle.titleStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Gap(20),
            Center(
              child: InkWell(
                onTap: addImage,
                child: Container(
                  width: 180,
                  height: 180,

                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: selectedImage != null
                      ? Image.file(selectedImage!, fit: BoxFit.cover)
                      : const Icon(Icons.person, size: 80, color: Colors.grey),
                ),
              ),
            ),
            Gap(30),
            TextFieldWidget(labelText: "Name", icons: null, controller: name),
            Gap(30),
            TextFieldWidget(
              labelText: "Surname",
              icons: null,
              controller: name,
            ),
            Gap(30),
            GenderDropdownWidget(
              value: selectedGender,
              onChanged: (val) => setState(() => selectedGender = val),
            ),
            Gap(30),
            DateOfBirthWidget(
              value: selectedDate,
              onChanged: (val) => setState(() => selectedDate = val),
            ),
            Gap(30),
            PhoneFieldWidget(
              labelText: "Phone Number",
              hintText: "XX XXX XXX",
              controller: phone,
            ),
            Gap(30),

            ButtonWidget(label: "Continue", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
