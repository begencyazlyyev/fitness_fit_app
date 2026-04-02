import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';

class ChooseGenderPage extends StatelessWidget {
  const ChooseGenderPage({super.key});

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
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.2, color: Colors.black),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            width: 180,
            height: 290,
            child: SizedBox(
              width: 150,
              height: 205,
              child: Image.asset(
                "assets/images/man-gym.jpg",
                fit: BoxFit.cover,
                width: 150,
                height: 205,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
