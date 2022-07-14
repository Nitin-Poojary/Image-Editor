import 'package:flutter/material.dart';

class ImageEditListModel {
  IconData icon;
  String iconName;
  VoidCallback onTap;

  ImageEditListModel(
      {required this.icon, required this.iconName, required this.onTap});
}
