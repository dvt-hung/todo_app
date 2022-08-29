import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/pages/home_page/home_page.dart';
import 'package:noteapp/pages/sign_up/sign_up_page.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_styles.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/validation.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  bool isValidation_Email = false;
  bool isValidation_Password = false;
  bool isShow = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  onTapSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpPage()));
  }

  login() {
    Api_Service.signIn(emailController.text, passController.text,
        (isLogin, msg) {
      if (Validation.checkEmail(emailController.text)) {
        if (isLogin) {
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(Dialogs.mySnackBar(msg));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 70.0,
                      ),
                      //EMAIL TEXTFIELD
                      Textfieldcomponent(
                        controller: emailController,
                        height: 50.0,
                        prefixIcon: const Icon(Icons.email),
                        suffxIcon: const Icon(Icons.person),
                        obscureText: false,
                        labelText: 'Email',
                        hintText: "Enter your Email:",
                        onChanged: (value) {
                          setState(() {
                            isValidation_Email =
                                Validation.checkEmail(emailController.text);
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 6.0,
                          left: 10.0,
                        ),
                        child: Text(
                            emailController.text
                                    .isEmpty // if email empty => Text =  ""
                                ? ""
                                : isValidation_Email // if email have value =? Check
                                    ? ''
                                    : "Email không hợp lệ",
                            style: AppStyles.style_error),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      //PASSWORD TEXTFIELD
                      Textfieldcomponent(
                        controller: passController,
                        height: 50.0,
                        prefixIcon: const Icon(Icons.lock),
                        suffxIcon: const Icon(
                          Icons.remove_red_eye,
                        ),
                        hintText: "Password",
                        labelText: "Password",
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      //BUTTON SIGNIN
                      Bunttoncomponent(
                        fontSize: 20,
                        width: double.infinity,
                        colorText: AppColor.thirdColor,
                        colorButton: AppColor.secondColor,
                        textButton: 'Sign In',
                        onTap: () {
                          Dialogs.showProgressDialog(context);
                          Future.delayed(const Duration(seconds: 1), () {
                            login();
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: onTapSignUp,
                          child: const TextRichcomponent(
                              colorOne: AppColor.primaryColor,
                              fontWeightOne: FontWeight.normal,
                              fontWeightTwo: FontWeight.bold,
                              textOne: 'Don\'t have an account?',
                              textTwo: ' Sign Up'),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
