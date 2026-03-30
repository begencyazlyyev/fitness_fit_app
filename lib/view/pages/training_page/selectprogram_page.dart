// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

class ProgramSelectionPage extends StatefulWidget {
  const ProgramSelectionPage({super.key});

  @override
  State<ProgramSelectionPage> createState() => _ProgramSelectionPageState();
}

final double spaceGap = 30;

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
          SizedBox(
            width: double.infinity,
            height: 300,
            child: Image.asset(image),
          ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Aligns "When lifting" with the right side
                  children: [
                    Text(
                      "When lifting",
                      style: KTextStyle.titleStyle.copyWith(fontSize: 18),
                    ),
                    // Specifics
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "25",
                            style: KTextStyle.titleStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(15),
                        Text(
                          "kg",
                          style: KTextStyle.fitStyle.copyWith(fontSize: 16),
                        ),
                        const Gap(5),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: -10, // pull up slightly
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Icon(Icons.arrow_drop_up, size: 40),
                                ),
                              ),
                              Positioned(
                                bottom: -10, // pull down slightly
                                child: Icon(Icons.arrow_drop_down, size: 40),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Image Video buttons
        ],
      ),
    );
  }
}
