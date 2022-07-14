import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imageeditor/provider/filterprovider.dart';
import 'package:provider/provider.dart';

import '../model/text.dart';
import '../provider/textprovider.dart';
import 'textelement.dart';

class EditableImage extends StatefulWidget {
  const EditableImage({Key? key, required this.imagepath}) : super(key: key);

  final imagepath;

  @override
  State<EditableImage> createState() => _EditableImageState();
}

class _EditableImageState extends State<EditableImage> {
  @override
  Widget build(BuildContext context) {
    TextProvider prvd = Provider.of<TextProvider>(context);
    List<TextInfo> texts = prvd.texts;

    return InteractiveViewer(
      child: Stack(
        children: [
          Hero(
            tag: "EditableImage",
            child: ColorFiltered(
              colorFilter: ColorFilter.matrix(
                  Provider.of<FilterProvider>(context).getFilter),
              child: Image.file(
                File(widget.imagepath),
              ),
            ),
          ),
          for (int i = 0; i < texts.length; i++)
            Positioned(
              left: texts[i].left,
              top: texts[i].top,
              child: Hero(
                tag: "texts",
                child: Draggable(
                  feedback: DisplayText(
                    textInfo: texts[i],
                    index: i,
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (drag) {
                    final renderBox = context.findRenderObject() as RenderBox;
                    Offset off = renderBox.globalToLocal(drag.offset);
                    setState(() {
                      Provider.of<TextProvider>(context, listen: false)
                          .setIndex(i);
                      texts[i].top = off.dy;
                      texts[i].left = off.dx;
                    });
                  },
                  child: DisplayText(
                    textInfo: texts[i],
                    index: i,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
