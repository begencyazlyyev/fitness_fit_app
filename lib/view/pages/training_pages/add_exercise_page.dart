import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddExercisePage extends StatefulWidget {
  const AddExercisePage({super.key});

  @override
  State<AddExercisePage> createState() => _AddExercisePageState();
}

class _AddExercisePageState extends State<AddExercisePage> {
  int selectedIndex = 0;

  // Helper list to make the code cleaner
  final List<String> images = [
    "assets/svg/chest_b.svg",
    "assets/svg/back_b.svg",
    "assets/svg/biceps_b.svg",
    "assets/svg/triceps_b.svg",
    "assets/svg/shoulders_b.svg",
    "assets/svg/waist_b.svg",
    "assets/svg/neck_b.svg",
    "assets/svg/upper-arm_b.svg",
    "assets/svg/forearms_b.svg",
    "assets/svg/quadriceps_b.svg",
    "assets/svg/hamstrings_b.svg",
    "assets/svg/hips_b.svg",
    "assets/svg/calves_b.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        titleSpacing: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close, size: 30, color: Color(0xFF111928)),
        ),
        title: Text("Add Exersices", style: KTextStyle.titleStyle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(images.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      // 2. Update the state and trigger a rebuild
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        border: selectedIndex == index
                            ? Border.all(color: Color(0xFF4B5563), width: 1.2)
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SvgPicture.asset(
                        images[index],
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          const Divider(color: Color(0xFFE5E7EB)),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 4.0, bottom: 4.0),
            child: Text(
              "Chest Exersices",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B5563),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                crossAxisCount: 2,
                childAspectRatio: 0.70,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE9ECF3),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey.shade400,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Colors.white, // inside container
                        ),
                        width: 195,
                        height: 184,
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: 8),
                        visualDensity: VisualDensity(vertical: -2),
                        title: Text(
                          "Bench Press",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text("Chest"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
