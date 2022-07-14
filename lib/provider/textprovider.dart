import 'package:flutter/cupertino.dart';
import 'package:imageeditor/model/text.dart';
import '../model/text.dart';

class TextProvider extends ChangeNotifier {
  List<TextInfo> texts = [];
  int index = 0;

  TextProvider() {
    init();
  }

  init() async {
    notifyListeners();
  }

  addText() {
    texts.add(TextInfo());
    notifyListeners();
  }

  removeText(int index) {
    texts.removeAt(index);
    notifyListeners();
  }

  removeAllTexts() {
    texts.clear();
  }

  setIndex(index) {
    this.index = index;
  }
}
