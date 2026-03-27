// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, int selectedPage, child) {
        return Container(
          height: 96,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
                spreadRadius: 1,
              ),
            ],
          ),
          //* Main NavBar
          child: BottomNavigationBar(
            currentIndex: selectedPage,
            onTap: (value) {
              selectedPageNotifier.value = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: selectedPage == 0
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: SvgPicture.asset(
                          "assets/svg/filled-dumbell.svg",
                          width: 22,
                          height: 22,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: SvgPicture.asset(
                          "assets/svg/outlined-dumbell.svg",
                          color: Colors.grey,
                          width: 22,
                          height: 22,
                        ),
                      ),
                label: "Training",
              ),
              BottomNavigationBarItem(
                icon: selectedPage == 1
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: SvgPicture.asset(
                          "assets/svg/programs-filled.svg",
                          fit: BoxFit.cover,

                          width: 29,
                          height: 29,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: SvgPicture.asset(
                          "assets/svg/programs-outlined.svg",
                          fit: BoxFit.cover,
                          color: Colors.grey,
                          width: 29,
                          height: 29,
                        ),
                      ),
                label: "Programs",
              ),
              BottomNavigationBarItem(
                icon: selectedPage == 2
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: SvgPicture.asset(
                          "assets/svg/calendar-filled.svg",
                          fit: BoxFit.cover,

                          width: 26,
                          height: 26,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: SvgPicture.asset(
                          "assets/svg/calendar-outlined.svg",
                          fit: BoxFit.cover,
                          color: Colors.grey,
                          width: 26,
                          height: 26,
                        ),
                      ),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: selectedPage == 3
                    ? Icon(Icons.person, size: 32, color: Color(0xFF4B5563))
                    : Icon(Icons.person_outline, size: 32, color: Colors.grey),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
