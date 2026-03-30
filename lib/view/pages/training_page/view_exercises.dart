import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

final List<String> categoryImages = [
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
  "assets/svg/calves.svg",
];

final List<String> categories = [
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
  "Calves",
];

Widget viewExercises(int selectedPage) {
  if (selectedPage == 0) {
    return TabBarView(
      children: [
        GridView.builder(
          padding: EdgeInsets.only(left: 8, right: 8, top: 18, bottom: 4),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 0.72,
            crossAxisCount: 3,
          ),
          itemCount: categoryImages.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 50,
              height: 50,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/add_exercise',
                    arguments: categories[index],
                  );
                },
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      categoryImages[index],
                      width: 130,
                      height: 130,
                    ),
                    Gap(6),
                    Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
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
