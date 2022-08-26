import 'package:flutter/cupertino.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_dimens.dart';

class AppStyles {
  static const TextStyle style_error =
      TextStyle(color: AppColor.redColor, fontSize: AppDimens.text_size_12);

  static const TextStyle h1 = TextStyle(
      color: AppColor.textColor,
      fontSize: AppDimens.text_size_18,
      fontWeight: FontWeight.bold);

  static const TextStyle h2 = TextStyle(
      color: AppColor.textColor,
      fontSize: AppDimens.text_size_16,
      fontWeight: FontWeight.bold);
  static const TextStyle h3 = TextStyle(
      color: AppColor.textColor,
      fontSize: AppDimens.text_size_14,
      fontWeight: FontWeight.bold);
  static const TextStyle h4 = TextStyle(
      color: AppColor.textColor,
      fontSize: AppDimens.text_size_12,
      fontWeight: FontWeight.bold);
}
