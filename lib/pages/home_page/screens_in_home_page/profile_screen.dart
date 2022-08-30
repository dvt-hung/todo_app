import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/pages/sign_in/sign_in_page.dart';
import 'package:noteapp/pages/update_info/update_info_page.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.secondColor,
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: CircleAvatar(
                  minRadius: 60,
                  child: FlutterLogo(
                    size: 90,
                  )),
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                    color: AppColor.thirdColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40, child: Text('Name:')),
                          const SizedBox(height: 40, child: Text('Email:')),
                          const SizedBox(height: 40, child: Text('Address:')),
                          const SizedBox(
                              height: 30, child: Text('Phone number:')),
                          const SizedBox(
                            height: 60,
                          ),
                          Bunttoncomponent(
                            colorText: AppColor.thirdColor,
                            colorButton: AppColor.secondColor,
                            onTap: changeInfo,
                            textButton: 'Change Info',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Bunttoncomponent(
                            colorText: AppColor.thirdColor,
                            colorButton: AppColor.redColor,
                            onTap: signOutAccount,
                            textButton: 'Sign Out',
                          ),
                        ]),
                  )),
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
    Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return const SignInPage();
      },
    ), (Route route) => false);
  }

  void changeInfo() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const UpdateInfoPage()));
  }
}
