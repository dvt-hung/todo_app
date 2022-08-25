import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/pages/sign_up/sign_up_page.dart';
import 'package:noteapp/utils/app_color.dart';

class SignInpage extends StatefulWidget {
  const SignInpage({Key? key}) : super(key: key);

  @override
  State<SignInpage> createState() => _SignInpageState();
}

class _SignInpageState extends State<SignInpage> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250.0,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
                child: TextRichcomponent(
                    fontSize: 35,
                    colorOne: AppColor.thirdColor,
                    colorTwo: AppColor.thirdColor,
                    fontWeightOne: FontWeight.bold,
                    fontWeightTwo: FontWeight.normal,
                    textOne: 'Sign In 😊',
                    textTwo: ' \nLet\'s get stared now!'),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70.0,
                    ),
                    //EMAIL TEXTFIELD
                    Textfieldcomponent(
                      // controller: emailController,
                      height: 50.0,
                      prefixIcon: const Icon(Icons.email),
                      suffxIcon: const Icon(Icons.person),
                      obscureText: false,
                      labelText: 'Email',
                      hintText: "Enter your Email:",
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    //PASSWORD TEXTFIELD
                    Textfieldcomponent(
                      // controller: passwordController,
                      height: 50.0,
                      prefixIcon: const Icon(Icons.lock),
                      suffxIcon: const Icon(
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

                    const SizedBox(
                      height: 50,
                    ),
                    //BUTTON SIGNIN
                    Bunttoncomponent(
                      fontSize: 20,
                      colorText: AppColor.thirdColor,
                      colorButton: AppColor.secondColor,
                      textButton: 'Sign In',
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    //TEXT SIGNUP
                    GestureDetector(
                      onTap: onTapSignUp,
                      child: const TextRichcomponent(
                          colorOne: AppColor.primaryColor,
                          fontWeightOne: FontWeight.normal,
                          fontWeightTwo: FontWeight.bold,
                          textOne: 'Don\'t have an account?',
                          textTwo: ' Sign Up'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }
}
