// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:noteapp/components/component_sign_in_sign_up/buntton_component.dart';
import 'package:noteapp/components/component_sign_in_sign_up/text_rich_component.dart';
import 'package:noteapp/components/component_sign_in_sign_up/textfield_component.dart';
import 'package:noteapp/utils/app_color.dart';

import '../sign_up/sign_up_page.dart';

String errorMessEmail = 'Invalid email';
String errorMessPass = 'Invalid password';

bool invalidEmail = false;
bool invalidPass = false;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.thirdColor,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300.0,
                  width: double.infinity,
                  child: //Text_Login
                      Padding(
                    padding: const EdgeInsets.fromLTRB(30, 150, 30, 0),
                    child: const TextRichcomponent(
                        fontSize: 35,
                        colorOne: AppColor.thirdColor,
                        colorTwo: AppColor.thirdColor,
                        fontWeightOne: FontWeight.bold,
                        fontWeightTwo: FontWeight.normal,
                        textOne: 'Sign In 😊',
                        textTwo: ' \nLet\'s get stared now!'),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: AppColor.secondColor),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
            Positioned(
                top: 370.0,
                right: 30,
                left: 30,
                child: Column(
                  children: [
                    //Email TextField
                    Textfieldcomponent(
                      height: 50.0,
                      prefixIcon: Icon(Icons.email),
                      suffxIcon: Icon(Icons.person),
                      obscureText: false,
                      labelText: 'Email',
                      hintText: "Enter your Email:",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //Password TextField
                    Textfieldcomponent(
                      height: 50.0,
                      prefixIcon: Icon(Icons.lock),
                      suffxIcon: Icon(
                        Icons.remove_red_eye,
                      ),
                      obscureText: !isShow,
                      onHide: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      labelText: 'Password',
                      hintText: 'Enter your Password:',
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    //Button
                    Bunttoncomponent(
                      fontSize: 20,
                      colorText: AppColor.thirdColor,
                      colorButton: AppColor.secondColor,
                      textButton: 'Sign In',
                    ),
                    //Text: SignIn
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: onTapSignUp,
                      child: TextRichcomponent(
                          colorOne: AppColor.primaryColor,
                          fontWeightOne: FontWeight.normal,
                          textOne: 'Don\'t have account?',
                          fontWeightTwo: FontWeight.bold,
                          textTwo: ' Sign Up'),
                    )
                  ],
                )),
          ],
        ));
  }

  onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }
}
