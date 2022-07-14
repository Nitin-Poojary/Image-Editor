import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:imageeditor/screens/filters/filtershome.dart';
import 'package:screenshot/screenshot.dart';
import '../animation/listAnimationEditScreen.dart';
import '../helperclasses/imageeditscreenhelperclass.dart';
import '../model/edittextlist.dart';
import '../model/imageeditlist.dart';
import '../widgets/editableimage.dart';

class ImageEdit extends StatefulWidget {
  const ImageEdit({Key? key, required this.imagepath}) : super(key: key);

  final String imagepath;

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends ImageEditHelper {
  Color myColor = Colors.black;
  bool textColorChanged = false,
      backgroundColorChanged = false,
      strokeColorChanges = false;

  @override
  Widget build(BuildContext context) {
    final List<ImageEditListModel> imageEditListItems = [
      ImageEditListModel(
        icon: Icons.text_fields_outlined,
        iconName: "Add Text",
        onTap: () {
          addText(context);
        },
      ),
      ImageEditListModel(
        icon: Icons.edit,
        iconName: "Edit Text",
        onTap: () {
          setState(
            () {
              enableEdit();
            },
          );
        },
      ),
      ImageEditListModel(
        icon: Icons.filter_list,
        iconName: "Filters",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterHome(imagePath: widget.imagepath),
            ),
          );
        },
      ),
      ImageEditListModel(
        icon: Icons.crop,
        iconName: "Crop",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FilterHome(imagePath: widget.imagepath),
            ),
          );
        },
      ),
    ];

    final List<EditTextList> textEditListItems = [
      EditTextList(
        icon: Icons.text_increase,
        iconName: "Size",
        onTap: () {
          setState(
            () {
              increaseSize(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.text_decrease,
        iconName: "Size",
        onTap: () {
          setState(
            () {
              decreaseSize(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.format_bold,
        iconName: "Bold",
        onTap: () {
          setState(
            () {
              bold(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.format_italic,
        iconName: "Italic",
        onTap: () {
          setState(
            () {
              italic(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.color_lens,
        iconName: "Text Colour",
        onTap: () async {
          textColorChanged = await selectColor();
          if (textColorChanged) {
            setState(() {
              textColour(context, myColor);
            });
          }
          textColorChanged = false;
        },
      ),
      EditTextList(
        icon: Icons.color_lens,
        iconName: "Background Colour",
        onTap: () async {
          backgroundColorChanged = await selectColor();
          if (backgroundColorChanged) {
            setState(() {
              backgroundColour(context, myColor);
            });
          }
          backgroundColorChanged = false;
        },
      ),
      EditTextList(
        icon: Icons.add,
        iconName: "Padding",
        onTap: () {
          setState(
            () {
              backgroundpaddingIncrease(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.minimize,
        iconName: "Padding",
        onTap: () {
          setState(
            () {
              backgroundpaddingDecrease(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.blur_linear,
        iconName: "Stroke",
        onTap: () async {
          strokeColorChanges = await selectColor();
          if (strokeColorChanges) {
            setState(() {
              strokeColour(context, myColor);
            });
          }
          strokeColorChanges = false;
        },
      ),
      EditTextList(
        icon: Icons.add,
        iconName: "Stroke",
        onTap: () {
          setState(
            () {
              strokeIncrease(context);
            },
          );
        },
      ),
      EditTextList(
        icon: Icons.minimize,
        iconName: "Stroke",
        onTap: () {
          setState(
            () {
              strokeDecrease(context);
            },
          );
        },
      ),
    ];

    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              setState(() {
                removeEdits();
              });
            },
            child: const Hero(
              tag: "cancel",
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.black,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  saveToGallery(context);
                  removeEdits();
                },
                child: const Hero(
                  tag: "done",
                  child: Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Screenshot(
                  controller: ssController,
                  child: EditableImage(imagepath: widget.imagepath),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Builder(
                builder: (context) {
                  if (isEditable) {
                    return ListAnimation(listItems: textEditListItems);
                  } else {
                    return ListAnimation(listItems: imageEditListItems);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        if (isEditable) {
          setState(
            () {
              enableEdit();
            },
          );
          return false;
        }
        removeEdits();
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
    );
  }

  Future<bool> selectColor() async {
    bool isClicked = false;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: myColor,
            onColorChanged: (newColor) => myColor = newColor,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              isClicked = true;
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        ],
      ),
    );
    return isClicked;
  }
}
