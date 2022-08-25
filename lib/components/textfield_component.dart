import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_color.dart';

class Textfieldcomponent extends StatelessWidget {
  String? labelText;
  String hintText;
  bool obscureText;
  Icon? prefixIcon;
  Icon? suffxIcon;
  VoidCallback? onHide;
  double? height;
  Color? color;
  // TextEditingController controller;
  // var icons_suffix;
  // var icons_suffix;
  Textfieldcomponent(
      {Key? key,
      required this.hintText,
      this.labelText,
      required this.obscureText,
      // required this.controller,
      this.prefixIcon,
      this.suffxIcon,
      this.height = 40.0,
      this.onHide,
      this.color = AppColor.secondColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        // controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color!),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: GestureDetector(
              onTap: () {
                if (onHide != null) {
                  onHide!();
                }
              },
              child: suffxIcon),
          border: OutlineInputBorder(

            borderSide: BorderSide(color: color!),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
