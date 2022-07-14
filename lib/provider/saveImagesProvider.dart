import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:imageeditor/model/savedimages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveImages extends ChangeNotifier {
  List<SavedImages> imagePaths = [];

  SaveImages() {
    init();
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("images");
    if (data != null) {
      var decoded = jsonDecode(data);
      imagePaths = decoded.map((e) {
        var ele = e as Map;
        return SavedImages.fromJson(ele);
      }).toList();
    }
  }

  Future<void> setImagePath(SavedImages imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imagePaths.add(imagePath);
    await prefs.setString(
        "images", jsonEncode(imagePaths.map((e) => e.toJson()).toList()));
    notifyListeners();
  }
}
