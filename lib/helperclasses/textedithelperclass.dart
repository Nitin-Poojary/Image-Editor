import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/textprovider.dart';

class TextEditHelper {
  int currentIndex = 0;
  bool isEditable = false;

  setIndex(int index) {
    currentIndex = index;
  }

  setProviderIndex(BuildContext context, int index) {
    Provider.of<TextProvider>(context, listen: false).setIndex(index);
  }

  getProviderIndex(BuildContext context) {
    return Provider.of<TextProvider>(context, listen: false).index;
  }

  addText(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false).addText();
  }

  removeText(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false).removeText(currentIndex);
  }

  enableEdit() => isEditable = !isEditable;

  increaseSize(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .fontSize += 2;
  }

  decreaseSize(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .fontSize -= Provider.of<TextProvider>(context, listen: false)
                .texts[getProviderIndex(context)]
                .fontSize ==
            0
        ? 0
        : 2;
  }

  bold(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
            .texts[getProviderIndex(context)]
            .bold =
        !Provider.of<TextProvider>(context, listen: false)
            .texts[getProviderIndex(context)]
            .bold;
  }

  italic(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
            .texts[getProviderIndex(context)]
            .italic =
        !Provider.of<TextProvider>(context, listen: false)
            .texts[getProviderIndex(context)]
            .italic;
  }

  textColour(BuildContext context, Color textColor) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .textColor = textColor;
  }

  backgroundColour(BuildContext context, Color backgroundColor) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .backgroundColor = backgroundColor;
  }

  backgroundpaddingIncrease(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .padding += 2;
  }

  backgroundpaddingDecrease(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .padding -= Provider.of<TextProvider>(context, listen: false)
                .texts[getProviderIndex(context)]
                .padding ==
            0
        ? 0
        : 2;
  }

  strokeIncrease(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .textStroke += 1;
  }

  strokeDecrease(BuildContext context) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .textStroke -= Provider.of<TextProvider>(context, listen: false)
                .texts[getProviderIndex(context)]
                .textStroke ==
            0
        ? 0
        : 1;
  }

  strokeColour(BuildContext context, Color strokeColor) {
    Provider.of<TextProvider>(context, listen: false)
        .texts[getProviderIndex(context)]
        .strokeColor = strokeColor;
  }
}
