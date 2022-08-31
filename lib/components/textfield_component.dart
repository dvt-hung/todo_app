import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_colors.dart';

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
  int? maxLine;
  bool? enable;

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
      this.maxLine = 1,
      this.enable = true,
      this.color = AppColor.secondColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        enabled: enable,
        maxLines: maxLine,
        controller: controller,
        obscureText: obscureText!,
        onChanged: onChanged,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
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
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
