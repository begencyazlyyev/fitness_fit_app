// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:flutter_svg/svg.dart';
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
                    Card(
                      color: selectedPage == 0
                          ? const Color(0xFFEDEDED)
                          : Colors.white,
                      elevation: selectedPage == 0 ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: selectedPage == 0
                            ? SvgPicture.asset(
                                "assets/svg/filled-dumbell.svg",
                                width: 21,
                                height: 21,
                              )
                            : SvgPicture.asset(
                                "assets/svg/outlined-dumbell.svg",
                                width: 21,
                                height: 21,
                                color: Colors.grey,
                              ),
                        title: Text(
                          "Training",
                          style: KTextStyle.drawerText.copyWith(
                            color: selectedPage == 0
                                ? const Color(0xFF4B5563)
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          selectedPageNotifier.value = 0;
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    //* Programs
                    Card(
                      color: selectedPage == 1
                          ? Color(0xFFEDEDED)
                          : Colors.white,
                      elevation: selectedPage == 1 ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: selectedPage == 1
                            ? SvgPicture.asset(
                                "assets/svg/programs-filled.svg",
                                width: 29,
                                height: 29,
                              )
                            : SvgPicture.asset(
                                "assets/svg/programs-outlined.svg",
                                width: 29,
                                height: 29,
                                color: Colors.grey,
                              ),
                        title: Text(
                          "Programs",
                          style: KTextStyle.drawerText.copyWith(
                            color: selectedPage == 1
                                ? const Color(0xFF4B5563)
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          selectedPageNotifier.value = 1;
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    //* History
                    Card(
                      color: selectedPage == 2
                          ? const Color(0xFFEDEDED)
                          : Colors.white,
                      elevation: selectedPage == 2 ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: selectedPage == 2
                            ? SvgPicture.asset(
                                "assets/svg/calendar-filled.svg",
                                width: 29,
                                height: 29,
                              )
                            : SvgPicture.asset(
                                "assets/svg/calendar-outlined.svg",
                                width: 29,
                                height: 29,
                                color: Colors.grey,
                              ),
                        title: Text(
                          "History",
                          style: KTextStyle.drawerText.copyWith(
                            color: selectedPage == 2
                                ? const Color(0xFF4B5563)
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          selectedPageNotifier.value = 2;
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    //* Profile
                    Card(
                      color: selectedPage == 3
                          ? const Color(0xFFEDEDED)
                          : Colors.white,
                      elevation: selectedPage == 3 ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: selectedPage == 3
                            ? const Icon(
                                Icons.person,
                                size: 32,
                                color: Color(0xFF4B5563),
                              )
                            : const Icon(
                                Icons.person_outline,
                                size: 32,
                                color: Colors.grey,
                              ),
                        title: Text(
                          "Profile",
                          style: KTextStyle.drawerText.copyWith(
                            color: selectedPage == 3
                                ? const Color(0xFF4B5563)
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          selectedPageNotifier.value = 3;
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    //* Bookmark
                    Card(
                      color: selectedPage == 4
                          ? const Color(0xFFEDEDED)
                          : Colors.white,
                      elevation: selectedPage == 4 ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: selectedPage == 4
                            ? const Icon(
                                Icons.bookmark,
                                size: 32,
                                color: Color(0xFF4B5563),
                              )
                            : const Icon(
                                Icons.bookmark_outline,
                                size: 32,
                                color: Colors.grey,
                              ),
                        title: Text(
                          "Bookmarks",
                          style: KTextStyle.drawerText.copyWith(
                            color: selectedPage == 4
                                ? const Color(0xFF4B5563)
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          selectedPageNotifier.value = 4;
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    //* Settings
                    Card(
                      color: selectedPage == 5
                          ? const Color(0xFFEDEDED)
                          : Colors.white,
                      elevation: selectedPage == 5 ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: selectedPage == 5
                            ? const Icon(
                                Icons.settings,
                                size: 32,
                                color: Color(0xFF4B5563),
                              )
                            : const Icon(
                                Icons.settings_outlined,
                                size: 32,
                                color: Colors.grey,
                              ),
                        title: Text(
                          "Settings",
                          style: KTextStyle.drawerText.copyWith(
                            color: selectedPage == 5
                                ? const Color(0xFF4B5563)
                                : Colors.grey,
                          ),
                        ),
                        onTap: () {
                          selectedPageNotifier.value = 5;
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Bottom Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(thickness: 1, color: Colors.grey.shade400),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Color(0xFF9C2007)),
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Color(0xFF9C2007),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/create_account');
                },
              ),
              Gap(150),
            ],
          );
        },
      ),
    ),
  );
}
