import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_color.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(130, 130),
                  bottomRight: Radius.circular(0),
                ),
                color: AppColor.secondColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
