// ignore_for_file: prefer_const_constructors,
import 'package:flutter/material.dart';

class Bunttoncomponent extends StatelessWidget {
  String? textButton;
  double? fontSize;
  Color? colorText;
  Color? colorButton;
  double? height;
  double? radius;
  VoidCallback onTap;

  Bunttoncomponent(
      {Key? key,
      this.textButton,
      this.fontSize,
      this.colorText,
      this.colorButton,
      required this.onTap,
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
          textButton!,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: colorText),
        ),
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(colorButton)),
      ),
    );
  }
}
