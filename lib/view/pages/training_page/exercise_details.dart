// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/mediabuttont_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({super.key});

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  bool isVideo = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    final String title = args is Map && args["title"] != null
        ? args["title"]
        : "Exercise";

    final String subtitle = args is Map && args["subtitle"] != null
        ? args["subtitle"]
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
        title: Text(title, style: KTextStyle.titleStyle),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 300,
              child: isVideo
                  ? const Center(
                      child: Text("Video Player Placeholder"),
                    ) // Logic for video
                  : Image.asset(image),
            ),
            const SizedBox(height: 10),
            // Image Video buttons
            Center(
              child: Container(
                margin: EdgeInsets.all(2),
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Image Button
                    GestureDetector(
                      onTap: () => setState(() => isVideo = false),
                      child: mediaButton(
                        "Image",
                        isActive: !isVideo,
                        isLeft: true,
                      ),
                    ),
                    // Video Button
                    GestureDetector(
                      onTap: () => setState(() => isVideo = true),
                      child: mediaButton(
                        "Video",
                        isActive: isVideo,
                        isLeft: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, bottom: 15),
              child: Text(
                "Muscles",
                style: KTextStyle.titleStyle.copyWith(fontSize: 20),
              ),
            ),
            //* Image details
            SizedBox(
              width: 250,
              height: 260,
              child: Image.asset(
                "assets/images/details.jpg",
                width: 250,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
            //* Exercise Details
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 20, bottom: 15),
              child: Text(
                "Exercise Details",
                style: KTextStyle.titleStyle.copyWith(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text("BODY PARTS", style: KTextStyle.solidText),
                      Gap(100),
                      Text(subtitle, style: KTextStyle.solidText),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("EQUIPMENT", style: KTextStyle.solidText),
                      Gap(105),
                      Text("Barbell", style: KTextStyle.solidText),
                    ],
                  ),
                ],
              ),
            ),
            //* Primary Muscles
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 20, bottom: 15),
              child: Text(
                "Primary Muscles",
                style: KTextStyle.titleStyle.copyWith(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("SECONDARY\nMUSCLES", style: KTextStyle.solidText),
                      Gap(100),
                      Flexible(
                        child: Text(
                          "deltoid_anterior, chest_clavicular_head, triceps",
                          style: KTextStyle.solidText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ButtonWidget(label: "Select Programs", onPressed: () {}),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
