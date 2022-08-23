import 'package:flutter/material.dart';
import 'package:noteapp/components/components_sign_in_sign_up/buntton_component.dart';
import 'package:noteapp/components/components_sign_in_sign_up/text_rich_component.dart';
import 'package:noteapp/utils/app_color.dart';

import '../../components/components_sign_in_sign_up/textfield_component.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShow1 = false;
  bool isShow2 = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.secondColor,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 600.0,
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    child: //Text_Login
                        const Padding(
                            padding: EdgeInsets.fromLTRB(30, 150, 30, 0),
                            child: TextRichcomponent(
                                fontSize: 34,
                                textOne: 'Sign Up',
                                fontWeightTwo: FontWeight.normal,
                                textTwo: '\nPlease fill full the information')),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: AppColor.thirdColor),
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
            Positioned(
                top: 330.0,
                right: 30,
                left: 30,
                child: Column(
                  children: [
                    //Email TextField
                    Textfieldcomponent(
                      height: 50.0,
                      prefixIcon: const Icon(Icons.email),
                      suffxIcon: const Icon(Icons.person),
                      obscureText: false,
                      hintText: "Sign up your Email:",
                      labelText: "Email:",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Password TextField1
                    Textfieldcomponent(
                      height: 50.0,
                      prefixIcon: const Icon(Icons.lock),
                      suffxIcon: const Icon(
                        Icons.remove_red_eye,
                      ),
                      obscureText: isShow1,
                      onHide: () {
                        setState(() {
                          isShow1 = !isShow1;
                        });
                      },
                      labelText: 'Password:',
                      hintText: 'Sign up your Password:',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //Password TextField2
                    Textfieldcomponent(
                      height: 50.0,
                      prefixIcon: const Icon(Icons.lock),
                      suffxIcon: const Icon(
                        Icons.remove_red_eye,
                      ),
                      obscureText: isShow2,
                      onHide: () {
                        setState(() {
                          isShow2 = !isShow2;
                        });
                      },
                      labelText: 'Password:',
                      hintText: 'Confirm your Password:',
                    ),

                    const SizedBox(
                      height: 90.0,
                    ),
                    //Button
                    Bunttoncomponent(
                      height: 60.0,
                      fontSize: 20,
                      colorText: AppColor.secondColor,
                      colorButton: AppColor.thirdColor,
                      textButton: 'Sign Up',
                    ),

                    const SizedBox(
                      height: 30.0,
                    ),

                    //Text
                    GestureDetector(
                      onTap: onClickSignIn,
                      child: const TextRichcomponent(
                          colorOne: AppColor.thirdColor,
                          colorTwo: AppColor.thirdColor,
                          fontWeightOne: FontWeight.normal,
                          fontWeightTwo: FontWeight.bold,
                          textOne: 'I already have an account!',
                          textTwo: ' Sign In'),
                    )
                  ],
                )),
          ],
        ));
  }

  onClickSignIn() {
    setState(() {
      Navigator.of(context).pop(true);
    });
  }
}
