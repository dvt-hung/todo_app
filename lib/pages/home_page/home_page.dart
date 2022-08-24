// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:noteapp/utils/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GNav(
            padding: EdgeInsets.all(16),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            backgroundColor: AppColor.secondColor,
            activeColor: AppColor.thirdColor,
            gap: 9,
            // onTabChange:  ,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                iconColor: AppColor.thirdColor,
                textColor: AppColor.thirdColor,
              ),
              GButton(
                hoverColor: AppColor.thirdColor,
                icon: Icons.account_circle,
                text: 'Account',
                iconColor: AppColor.thirdColor,
                textColor: AppColor.thirdColor,
              ),
            ]),
      ),
      backgroundColor: AppColor.thirdColor,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 500,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
          ),
          Container(
            height: 1500.0,
            width: double.infinity,
          )
        ]),
      ),
    );
  }
}
