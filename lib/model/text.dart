import 'package:flutter/material.dart';

class TextInfo {
  String text;
  Color textColor;
  Color backgroundColor;
  TextAlign textPosition;
  double left;
  double top;
  bool bold;
  bool italic;
  double textStroke;
  Color strokeColor;
  double fontSize;
  double padding;

  TextInfo({
    this.text = "Add Text",
    this.textColor = Colors.white,
    this.backgroundColor = Colors.transparent,
    this.textPosition = TextAlign.center,
    this.left = 0,
    this.top = 0,
    this.bold = false,
    this.italic = false,
    this.textStroke = 0.0,
    this.strokeColor = Colors.black,
    this.fontSize = 22,
    this.padding = 0,
  });
}
