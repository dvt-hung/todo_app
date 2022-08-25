// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/pages/home_page/screens_in_home_page/add_note_screen.dart';
import 'package:noteapp/pages/home_page/screens_in_home_page/home_screen.dart';
import 'package:noteapp/pages/home_page/screens_in_home_page/profile_screen.dart';
import 'package:noteapp/utils/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final screens = [
    Homescreen(),
    AddNotescreen(),
    Profilescreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30, color: AppColor.thirdColor),
      Icon(Icons.add_circle, size: 30, color: AppColor.thirdColor),
      Icon(Icons.account_circle, size: 30, color: AppColor.thirdColor),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: AppColor.thirdColor,
        title: Text(
          'Home',
          style: TextStyle(
              color: AppColor.secondColor,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        items: items,
        color: AppColor.secondColor,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: AppColor.secondColor,
        onTap: (index) => setState(() => this.index = index),
      ),
      body: screens[index],
    );
  }
}
