import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/pages/sign_in/sign_in_page.dart';
import 'package:noteapp/pages/update_info/update_info_page.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_dimens.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel user = UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Singleton().user != null) {
      user = Singleton().user!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.secondColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  ClipOval(
                    child: user.image!.isNotEmpty
                        ? Image.network(
                            user.image!,
                            height: 110,
                            width: 110,
                          )
                        : const FlutterLogo(
                            size: 90,
                          ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      '${(user.name != null && user.name!.isNotEmpty) ? user.name : "Chưa cập nhật"}',
                      style: const TextStyle(
                          fontSize: AppDimens.text_size_16,
                          fontWeight: FontWeight.bold,
                          color: AppColor.thirdColor),
                    ),
                  ),
                  Text(
                    '${(user.email != null && user.email!.isNotEmpty) ? user.email : "Chưa cập nhật"}',
                    style: const TextStyle(
                        fontSize: AppDimens.text_size_16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.thirdColor),
                  ),
                ],
              ),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30, top: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.greyColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Name: ${(user.name != null && user.name!.isNotEmpty) ? user.name : "Chưa cập nhật"}',
                                  style: const TextStyle(
                                      fontSize: AppDimens.text_size_16),
                                ),
                              ),
                            ),
                          ),

                          // SizedBox(
                          //   height: 40,
                          //   child: Text(
                          //     'Email: ${(user.email != null && user.email!.isNotEmpty) ? user.email : "Chưaa cập nhật"}',
                          //     style: const TextStyle(
                          //         fontSize: AppDimens.text_size_16),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.greyColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Address: ${(user.address != null && user.address!.isNotEmpty) ? user.address : "Chưa cập nhật"}',
                                  style: const TextStyle(
                                      fontSize: AppDimens.text_size_16),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.greyColor,
                                  borderRadius: BorderRadius.circular(5)),
                              height: 40,
                              child: Center(
                                child: Text(
                                  'Phone: ${(user.phone != null && user.phone!.isNotEmpty) ? user.phone : "Chưa cập nhật"}',
                                  style: const TextStyle(
                                      fontSize: AppDimens.text_size_16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Bunttoncomponent(
                                height: 45.0,
                                width: 150.0,
                                colorText: AppColor.thirdColor,
                                colorButton: AppColor.redColor,
                                onTap: signOutAccount,
                                textButton: 'Sign Out',
                              ),
                              Bunttoncomponent(
                                height: 45.0,
                                width: 150.0,
                                colorText: AppColor.thirdColor,
                                colorButton: AppColor.secondColor,
                                onTap: changeInfo,
                                textButton: 'Change Info',
                              ),
                            ],
                          )
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void signOutAccount() {
    Singleton().logout();
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
