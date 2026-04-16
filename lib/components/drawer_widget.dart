// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/side_svg_widget.dart';
import 'package:flutter_application_1/components/side_icon_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:gap/gap.dart';

//* Drawer
Widget buildDrawer(BuildContext context) {
  return SafeArea(
    child: Drawer(
      elevation: 0,
      backgroundColor: Colors.white,
      child: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, int selectedPage, child) {
          final userState = context.watch<UserCubit>().state;
          final user = userState.users.isNotEmpty ? userState.users.last : null;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // 🔹 Custom Header
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: const BoxDecoration(color: Color(0xFFE9ECF3)),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 46,
                            backgroundImage: user?.imagePath != null
                                ? FileImage(File(user!.imagePath!))
                                : const AssetImage("assets/images/profile.jpg")
                                      as ImageProvider,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            user != null
                                ? "${user.name} ${user.surname}"
                                : "Guest",
                            style: const TextStyle(
                              color: Color(0xFF1C2A3A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            user?.email ?? "No email",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //* Training
                    SideWidget(
                      index: 0,
                      imageActive: "assets/svg/filled-dumbell.svg",
                      imageInactive: "assets/svg/outlined-dumbell.svg",
                      title: "Training",
                      onTap: () {
                        selectedPageNotifier.value = 0;
                        Navigator.pop(context);
                      },
                    ),

                    //* Programs
                    SideWidget(
                      index: 1,
                      imageActive: "assets/svg/programs-filled.svg",
                      imageInactive: "assets/svg/programs-outlined.svg",
                      title: "Programs",
                      onTap: () {
                        selectedPageNotifier.value = 1;
                        Navigator.pop(context);
                      },
                    ),

                    //* History
                    SideWidget(
                      index: 2,
                      imageActive: "assets/svg/calendar-filled.svg",
                      imageInactive: "assets/svg/calendar-outlined.svg",
                      title: "History",
                      onTap: () {
                        selectedPageNotifier.value = 2;
                        Navigator.pop(context);
                      },
                    ),

                    //* Profile
                    SideIconWidget(
                      index: 3,
                      activeIcon: Icons.person,
                      inactiveIcon: Icons.person_outline,
                      title: "Profile",
                      onTap: () {
                        selectedPageNotifier.value = 3;
                        Navigator.pop(context);
                      },
                    ),

                    //* Bookmark
                    SideIconWidget(
                      index: 4,
                      activeIcon: Icons.bookmark,
                      inactiveIcon: Icons.bookmark_outline,
                      title: "Bookmark",
                      onTap: () {
                        selectedPageNotifier.value = 4;
                        Navigator.pop(context);
                      },
                    ),
                    //* Settings
                    SideIconWidget(
                      index: 5,
                      activeIcon: Icons.settings,
                      inactiveIcon: Icons.settings_outlined,
                      title: "Settings",
                      onTap: () {
                        selectedPageNotifier.value = 5;
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(width: 100, height: 1, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Transform.rotate(
                        angle: 45 * (3.14159 / 180),
                        child: Container(
                          width: 10,
                          height: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Container(width: 100, height: 1, color: Colors.grey),
                  ],
                ),
              ),
              // 🔹 Bottom Section
              ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFF2C2C2E)),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Color(0xFF2C2C2E),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/create_account');
                },
              ),
              Gap(50),
            ],
          );
        },
      ),
    ),
  );
}
