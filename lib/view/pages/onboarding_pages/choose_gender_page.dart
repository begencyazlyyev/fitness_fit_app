import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/button_widget.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';
import 'package:gap/gap.dart';

class ChooseGenderPage extends StatefulWidget {
  const ChooseGenderPage({super.key});

  @override
  State<ChooseGenderPage> createState() => _ChooseGenderPageState();
}

class _ChooseGenderPageState extends State<ChooseGenderPage> {
  bool isMaleSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Choose workout gender", style: KTextStyle.fitStyle),
          ),
          SizedBox(
            width: 250,
            height: 100,
            child: Center(
              child: Text(
                "Knowing your workout type can help the intensity for you based on different metabolic rates.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ),
          Gap(70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Male Container
              GestureDetector(
                onTap: () => setState(() => isMaleSelected = true),
                child: Opacity(
                  opacity: isMaleSelected ? 1.0 : 0.4,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: isMaleSelected
                          ? Border.all(width: 1.2, color: Colors.black)
                          : Border.all(width: 0, color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    width: 180,
                    height: 320,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/images/man-gym.jpg",
                            width: 160,
                            height: 270,
                          ),
                        ),
                        Text(
                          "Male",
                          style: KTextStyle.fitStyle.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Female Container
              GestureDetector(
                onTap: () => setState(() => isMaleSelected = false),
                child: Opacity(
                  opacity: isMaleSelected ? 0.4 : 1.0,
                  child: Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: isMaleSelected
                          ? Border.all(width: 0, color: Colors.transparent)
                          : Border.all(width: 1.2, color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    width: 180,
                    height: 320,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/images/woman-gym.jpg",
                            width: 160,
                            height: 270,
                          ),
                        ),
                        Text(
                          "Female",
                          style: KTextStyle.fitStyle.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(80),
          ButtonWidget(label: "Continue", onPressed: () {}),
        ],
      ),
    );
  }
}
