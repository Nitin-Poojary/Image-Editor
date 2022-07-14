import 'dart:io';

import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Expanded(
            child: InteractiveViewer(
              child: Hero(
                tag: "viewImage",
                child: Image.file(
                  File(imagePath),
                ),
              ),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
