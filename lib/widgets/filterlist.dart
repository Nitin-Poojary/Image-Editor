import 'dart:io';

import 'package:flutter/material.dart';

class FilterList extends StatelessWidget {
  const FilterList({
    Key? key,
    required this.imagePath,
    required this.filters,
    required this.filterName,
    required this.isActive,
  }) : super(key: key);

  final String imagePath;
  final List<double> filters;
  final String filterName;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: isActive ? Colors.black : Colors.transparent,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            duration: const Duration(milliseconds: 380),
            child: FittedBox(
              fit: BoxFit.none,
              child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(filters),
                  child: Image.file(height: 50, width: 60, File(imagePath))),
            ),
          ),
          Text(filterName)
        ],
      ),
    );
  }
}
