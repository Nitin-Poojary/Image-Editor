import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import '../helperclasses/textedithelperclass.dart';
import '../model/text.dart';

class DisplayText extends StatefulWidget {
  const DisplayText({Key? key, required this.textInfo, required this.index})
      : super(key: key);

  final TextInfo textInfo;
  final int index;

  @override
  State<DisplayText> createState() => _DisplayTextState();
}

class _DisplayTextState extends State<DisplayText> with TextEditHelper {
  bool _isEditable = false;
  final TextEditingController _controller = TextEditingController();
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.textInfo.text;
    if (_isEditable) {
      return Container(
        color: widget.textInfo.backgroundColor,
        padding: EdgeInsets.all(widget.textInfo.padding),
        width: 120,
        child: TextField(
          style: TextStyle(
            color: widget.textInfo.textColor,
            fontSize: widget.textInfo.fontSize,
            fontWeight:
                widget.textInfo.bold ? FontWeight.bold : FontWeight.normal,
            fontStyle:
                widget.textInfo.italic ? FontStyle.italic : FontStyle.normal,
          ),
          textAlign: TextAlign.center,
          controller: _controller,
          autofocus: true,
          onSubmitted: (newValue) {
            setState(() {
              widget.textInfo.text = newValue;
              _isEditable = false;
            });
          },
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() => _isEditable = true);
        setProviderIndex(context, widget.index);
        setIndex(widget.index);
      },
      onLongPress: () {
        setIndex(widget.index);
        setProviderIndex(context, widget.index);
        removeText(context);
      },
      child: Container(
        padding: EdgeInsets.all(widget.textInfo.padding),
        decoration: BoxDecoration(color: widget.textInfo.backgroundColor),
        child: BorderedText(
          strokeColor: widget.textInfo.strokeColor,
          strokeWidth: widget.textInfo.textStroke,
          child: Text(
            widget.textInfo.text,
            style: TextStyle(
              color: widget.textInfo.textColor,
              fontSize: widget.textInfo.fontSize,
              fontWeight:
                  widget.textInfo.bold ? FontWeight.bold : FontWeight.normal,
              fontStyle:
                  widget.textInfo.italic ? FontStyle.italic : FontStyle.normal,
            ),
            textAlign: widget.textInfo.textPosition,
          ),
        ),
      ),
    );
  }
}
