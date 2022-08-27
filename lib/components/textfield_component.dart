import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_styles.dart';

class Textfieldcomponent extends StatelessWidget {
  String? labelText;
  String? hintText;
  bool? obscureText;
  Icon? prefixIcon;
  Icon? suffxIcon;
  VoidCallback? onHide;
  double? height;
  Color? color;
  TextEditingController controller;
  ValueChanged<String>? onChanged;

  Textfieldcomponent(
      {Key? key,
      this.onChanged,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      required this.controller,
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
        controller: controller,
        obscureText: obscureText!,
        onChanged: onChanged,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color!),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffxIcon != null
              ? IconButton(
                  icon: suffxIcon!,
                  onPressed: onHide,
                )
              : const SizedBox.shrink(),
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
