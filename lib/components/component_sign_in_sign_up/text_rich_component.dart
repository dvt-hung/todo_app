import 'package:flutter/material.dart';

class TextRichcomponent extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final FontWeight? fontWeightOne;
  final FontWeight? fontWeightTwo;
  final double? fontSize;
  final Color? colorOne;
  final Color? colorTwo;

  const TextRichcomponent({
    Key? key,
    required this.textOne,
    required this.textTwo,
    this.fontSize = 12,
    this.fontWeightOne = FontWeight.bold,
    this.fontWeightTwo = FontWeight.normal,
    this.colorOne = Colors.blue,
    this.colorTwo = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: textOne,
            style: TextStyle(
                fontWeight: fontWeightOne!,
                color: colorOne,
                fontSize: fontSize),
          ),
          TextSpan(
            text: textTwo,
            style: TextStyle(
                fontWeight: fontWeightTwo!,
                color: colorTwo,
                fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
