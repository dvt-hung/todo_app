// ignore_for_file: prefer_const_constructors,
import 'package:flutter/material.dart';

class Bunttoncomponent extends StatelessWidget {
  String textButton;
  double fontSize;
  var colorText;
  var colorButton;
  double? height;
  double? radius;

  Bunttoncomponent(
      {Key? key,
      required this.textButton,
      required this.fontSize,
      required this.colorText,
      required this.colorButton,
      this.height = 50,
      onHide})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height!,
      width: double.infinity,
      child: TextButton(
        child: Text(
          textButton,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorText),
        ),
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colorButton)),
      ),
    );
  }
}
