import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/item_menu_component.dart';
import 'package:noteapp/pages/sign_in/sign_in_page.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_styles.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class MenuModel {
  int idMenu;
  String title;

  MenuModel({required this.idMenu, required this.title});
}

class Profilescreen extends StatefulWidget {
  const Profilescreen({Key? key}) : super(key: key);

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  List<MenuModel> listMenus = [
    MenuModel(idMenu: 0, title: "Thông tin cá nhân"),
    MenuModel(idMenu: 1, title: "Cài đặt"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            const CircleAvatar(
              backgroundColor: AppColor.thirdColor,
              minRadius: 50.0,
              child: FlutterLogo(
                size: 60,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Singleton().user!.name!,
              style: AppStyles.h1,
            ),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
              itemCount: listMenus.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ItemMenuComponent(
                  items: listMenus[index],
                  onTap: () {
                    switch (index) {
                      case 0:
                        break;
                      case 1:
                        break;
                    }
                  },
                );
              },
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: Bunttoncomponent(
                textButton: "Đăng xuất",
                colorButton: AppColor.redColor,
                colorText: AppColor.thirdColor,
                onTap: () {
                  signOutAccount();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signOutAccount() {
    // Show dialog progress
    Dialogs.showProgressDialog(context);

    // Sign out
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Singleton().logOut();
      Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return const SignInPage();
        },
      ), (Route route) => false);
    });
  }
}
