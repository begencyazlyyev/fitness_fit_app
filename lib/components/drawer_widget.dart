import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
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
                        children: const [
                          CircleAvatar(
                            radius: 46,
                            backgroundImage: AssetImage(
                              "assets/images/profile.jpg",
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Sapar Meredow",
                            style: TextStyle(
                              color: Color(0xFF1C2A3A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "saparmaredow@gmail.com",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    //* Training
                    Card(
                      color: selectedPage == 0
                          ? Color(0xFFEDEDED)
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
                    ListTile(
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

                    //* Profile
                    ListTile(
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
                  // Add logout logic here
                },
              ),
              Gap(300),
            ],
          );
        },
      ),
    ),
  );
}
