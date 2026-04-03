import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_style_widget.dart';

Widget resolIndicator(int counter, String name) {
  return Column(
    children: <Widget>[
      Text("$counter", style: KTextStyle.fitnessStyle.copyWith(fontSize: 20)),
      Text(name, style: KTextStyle.fitnessStyle.copyWith(fontSize: 14)),
    ],
  );
}
