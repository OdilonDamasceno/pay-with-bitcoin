import 'package:flutter/material.dart';

class CustomRichText extends StatefulWidget {
  final String simpleText;
  final String presText;
  final void Function() onTap;
  final TextStyle pressStyle;
  final TextStyle simpleStyle;

  const CustomRichText({
    Key key,
    this.simpleStyle = const TextStyle(),
    this.simpleText,
    this.presText,
    this.onTap,
    this.pressStyle = const TextStyle(
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);
  @override
  _CustomRichTextState createState() => _CustomRichTextState();
}

class _CustomRichTextState extends State<CustomRichText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "${widget.simpleText}",
          style: widget.simpleStyle,
        ),
        GestureDetector(
          child: Text(
            "${widget.presText}",
            style: widget.pressStyle,
          ),
          onTap: widget.onTap,
        )
      ],
    );
  }
}
