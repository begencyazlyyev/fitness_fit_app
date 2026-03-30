// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/selection_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:flutter_application_1/components/textbutton_widget.dart';
import 'package:flutter_application_1/data/notifiers.dart';
import 'package:gap/gap.dart';

class ProgramSelectionPage extends StatefulWidget {
  const ProgramSelectionPage({super.key});

  @override
  State<ProgramSelectionPage> createState() => _ProgramSelectionPageState();
}

final double spaceGap = 40;

class _ProgramSelectionPageState extends State<ProgramSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    final String category = args is Map && args["category"] != null
        ? args["category"]
        : "Not Found";

    // 2. Provide a fallback or handle null for the asset path
    final String image = (args is Map && args["image"] != null)
        ? args["image"]
        : "assets/placeholder.png";

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.grey.withOpacity(0.6),
        scrolledUnderElevation: 1.5,
        centerTitle: true,
        title: Text("Program selection", style: KTextStyle.titleStyle),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Main image
          SizedBox(
            width: double.infinity,
            height: 310,
            child: Image.asset(image),
          ),
          Gap(10),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //* Workout type
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Workout type",
                      style: KTextStyle.titleStyle.copyWith(fontSize: 18),
                    ),
                    Text(
                      category,
                      style: KTextStyle.titleStyle.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Gap(spaceGap),
                //* When lifting
                SelectionWidget(
                  workout: "When lifting",
                  weight: 25,
                  type: "  kg  ",
                ),
                Gap(spaceGap),

                // Till I can do
                SelectionWidget(
                  workout: "Till tired, I can do",
                  weight: 10,
                  type: "Reps",
                ),
                Gap(spaceGap),

                // Quantity of sets
                SelectionWidget(
                  workout: "For each exercise",
                  weight: 4,
                  type: "Sets",
                ),
              ],
            ),
          ),
          Gap(10),

          // Button
          Stack(
            children: [
              ButtonWidget(label: "Add to Programs", onPressed: () {}),
              Positioned(
                top: 30,
                right: 85,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          ValueListenableBuilder(
            valueListenable: selectedPageNotifier,
            builder: (context, int selectedPage, child) {
              return textbuttonWidget(() {
                selectedPageNotifier.value = 1;

                Navigator.of(context).popUntil((route) => route.isFirst);
              }, "Go to Programs >");
            },
          ),
          // Image Video buttons
        ],
      ),
    );
  }
}
