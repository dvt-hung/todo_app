import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_styles.dart';

class ItemMenuComponent extends StatelessWidget {
  // MenuModel items;
  VoidCallback onTap;
  ItemMenuComponent(
      {Key? key
      // ,required this.items
      ,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColor.thirdColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(
              '',
              // items.title,
              style: AppStyles.h3.copyWith(fontWeight: FontWeight.normal),
            ),
            const Spacer(),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }
}
