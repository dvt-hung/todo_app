import 'package:flutter/material.dart';
import 'package:noteapp/components/component_sign_in_sign_up/buntton_component.dart';
import 'package:noteapp/components/component_sign_in_sign_up/text_rich_component.dart';
import 'package:noteapp/components/component_sign_in_sign_up/textfield_component.dart';
import 'package:noteapp/utils/app_color.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShow1 = false;
  bool isShow2 = false;

  onClickSignIn() {
    setState(() {
      Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 570.0,
              width: double.infinity,
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                      color: AppColor.thirdColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      )),
                ),
                Positioned(
                  top: 130,
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

                      //TEXTFIELD EMAIL
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Textfieldcomponent(
                          height: 50.0,
                          prefixIcon: const Icon(Icons.email),
                          suffxIcon: const Icon(Icons.person),
                          obscureText: false,
                          hintText: "Sign up your Email:",
                          labelText: "Enter Email:",
                        ),
                      ),

                      //TEXTFIELD PASSWORD
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Textfieldcomponent(
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
                          labelText: 'Enter Password:',
                          hintText: 'Sign up your Password:',
                        ),
                      ),
                      //TEXTFIELD PASSWORD CONFIRM
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Textfieldcomponent(
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
                          labelText: 'Confirm Password:',
                          hintText: 'Confirm your Password:',
                        ),
                      ),
                    ],
                  ),
                )
              ]),
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
            )
          ],
        ),
      ),
    );
  }
}
