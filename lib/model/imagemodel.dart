import 'dart:io';

import 'package:flutter/material.dart';

class HomeScreenImages extends StatelessWidget {
  const HomeScreenImages({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76,
      width: 76,
      child: FittedBox(
        fit: BoxFit.cover,
        clipBehavior: Clip.hardEdge,
        child: Hero(
          tag: "viewImage",
          child: Image.file(
            File(imagePath),
          ),
        ),
      ),
    );
  }
}
