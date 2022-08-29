import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/service/api_service.dart';

import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/validation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool isPass = true;
  bool isShow1 = false;
  bool isShow2 = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  onClickSignIn() {
    setState(() {
      Navigator.of(context).pop(true);
    });
  }

  void signUpAccount(String email, String password, String passwordConfirm) {
    if (email.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
      Dialogs.showMyDialog(context, "Thông báo", "Dữ liệu đang bị trống");
    } else if (password != passwordConfirm) {
      Dialogs.showMyDialog(context, "Thông báo", "Mật khẩu không trùng khớp");
    } else if (!Validation.checkEmail(email)) {
      Dialogs.showMyDialog(context, "Thông báo", "Email không hợp lệ");
    } else if (!Validation.checkPassword(password)) {
      Dialogs.showMyDialog(context, "Thông báo", "Mật khẩu không hợp lệ");
    } else {
      Api_Service.registerEmail(email, password, (smg, isSuccess) {
        if (isSuccess) {
          Navigator.of(context).pop();
        } else {
          Dialogs.showMyDialog(context, "Thông báo", smg);
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColor.secondColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 470.0,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColor.thirdColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35),
                          bottomRight: Radius.circular(35),
                        )),
                  ),
                  Positioned(
                    top: 50,
                    left: 30,
                    right: 30,
                    child: Column(
                      children: [
                        //TEXT SIGN UP
                        const Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: TextRichcomponent(
                              fontSize: 34,
                              textOne: 'Sign Up',
                              fontWeightTwo: FontWeight.normal,
                              textTwo: '\nPlease fill full the information'),
                        ),

                        //BUTTON SIGN UP
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
                          child: Bunttoncomponent(
                            height: 60.0,
                            fontSize: 20,
                            colorText: AppColor.secondColor,
                            colorButton: AppColor.thirdColor,
                            textButton: 'Sign Up',
                            onTap: () {
                              String email = emailController.text;
                              String password = passwordController.text;
                              String passwordConfirm =
                                  passwordConfirmController.text;
                            },
                          ),
                        ),
                        //TEXTFIELD PASSWORD
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Textfieldcomponent(
                            controller: passwordController,
                            height: 50.0,
                            prefixIcon: const Icon(Icons.lock),
                            suffxIcon: const Icon(
                              Icons.remove_red_eye,
                            ),
                            obscureText: !isShow1,
                            onHide: () {
                              setState(() {
                                isShow1 = !isShow1;
                              });
                            },
                            labelText: 'Enter Password:',
                            hintText: 'Sign up your Password:',
                          ),
                        ),
                        //TEXTFIELD PASSWORD CONFIRM
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Textfieldcomponent(
                            onChanged: (value) {
                              setState(() {
                                isPass = Validation.checkPassword(value);
                              });
                            },
                            controller: passwordConfirmController,
                            height: 50.0,
                            prefixIcon: const Icon(Icons.lock),
                            obscureText: !isShow2,
                            onHide: () {
                              setState(() {
                                isShow2 = !isShow2;
                              });
                            },
                            labelText: 'Confirm Password:',
                            hintText: 'Confirm your Password:',
                          ),
                        ),
                      ],
                    ),
                  ),
                  //BUTTON SIGN UP
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
                    child: Bunttoncomponent(
                      height: 60.0,
                      fontSize: 20,
                      colorText: AppColor.secondColor,
                      colorButton: AppColor.thirdColor,
                      textButton: 'Sign Up',
                      onTap: () {
                        String email = emailController.text;
                        String password = passwordController.text;
                        String passwordConfirm = passwordConfirmController.text;
                        Dialogs.showProgressDialog(context);
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop(true);
                          signUpAccount(email, password, passwordConfirm);
                        });
                      },
                    ),
                  ),

                  //TEXT BACK TO SIGN IN
                  GestureDetector(
                    onTap: onClickSignIn,
                    child: const TextRichcomponent(
                        colorOne: AppColor.thirdColor,
                        colorTwo: AppColor.thirdColor,
                        fontWeightOne: FontWeight.normal,
                        fontWeightTwo: FontWeight.bold,
                        textOne: 'I already have an account!',
                        textTwo: ' Sign In'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkPassword(String pass) {
    bool passwordValid =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(pass);
    return passwordValid;
  }

  void checkEmailPassword(String email, String pass) {
    String msg_EmailValid = "Email không hợp lệ";

    // Regex Email
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (!emailValid) {
      Dialogs.showMyDialog(context, "Thông báo", msg_EmailValid);
    } else if (emailValid) {
      Api_Service.registerEmail(email, pass, (msg, isSuccess) {
        if (isSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(Dialogs.mySnackBar(msg));
        } else {
          Dialogs.showMyDialog(context, "Thông báo", msg);
        }
      });
    }
  }
}
