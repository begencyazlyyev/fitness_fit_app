import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

final List<String> images = [
  "assets/svg/chest.svg",
  "assets/svg/back.svg",
  "assets/svg/biceps.svg",
  "assets/svg/triceps.svg",
  "assets/svg/shoulder.svg",
  "assets/svg/waist.svg",
  "assets/svg/neck.svg",
  "assets/svg/upper-arm.svg",
  "assets/svg/forearm.svg",
  "assets/svg/quadriceps.svg",
  "assets/svg/hamstrings.svg",
  "assets/svg/hips.svg",
];

final List<String> titles = [
  "Chest",
  "Back",
  "Biceps",
  "Triceps",
  "Shoulder",
  "Waist",
  "Neck",
  "Upper Arm",
  "Forearm",
  "Quadriceps",
  "Hamstrings",
  "Hips",
];

Widget buildBody(int selectedPage) {
  if (selectedPage == 0) {
    return TabBarView(
      children: [
        GridView.builder(
          padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 18),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.72,
            crossAxisCount: 3,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 50,
              height: 50,
              child: Column(
                children: <Widget>[
                  SvgPicture.asset(images[index], width: 130, height: 130),
                  Gap(6),
                  Text(
                    titles[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        //* Second Tab
        Center(child: Text("No available couches yet")),
      ],
    );
  } else {
    return pages.elementAt(selectedPage);
  }
}
