import 'package:flutter/material.dart';
import 'package:noteapp/components/components_sign_in_sign_up/buntton_component.dart';
import 'package:noteapp/components/components_sign_in_sign_up/text_rich_component.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_color.dart';
import 'package:noteapp/utils/dialogs.dart';

import '../../components/components_sign_in_sign_up/textfield_component.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShow1 = false;
  bool isShow2 = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.thirdColor,
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
          child: Column(
            children: [
              const Text("sadadasd"),
              //Email TextField
              Textfieldcomponent(
                controller: emailController,
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
                labelText: 'Password:',
                hintText: 'Sign up your Password:',
              ),
              const SizedBox(
                height: 30,
              ),
              //Password TextField2
              Textfieldcomponent(
                controller: passwordConfirmController,
                height: 50.0,
                prefixIcon: const Icon(Icons.lock),
                suffxIcon: const Icon(
                  Icons.remove_red_eye,
                ),
                obscureText: !isShow2,
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
                  onTap: () {
                    Api_Service.registerEmail(
                        emailController.text, passwordController.text, (msg) {
                      Dialogs.showMyDialog(context, "Thông báo", msg);
                    });
                  }),

              const SizedBox(
                height: 30.0,
              ),

              //Text
              Expanded(
                child: GestureDetector(
                  onTap: onClickSignIn,
                  child: const TextRichcomponent(
                      colorOne: AppColor.secondColor,
                      colorTwo: AppColor.secondColor,
                      fontWeightOne: FontWeight.normal,
                      fontWeightTwo: FontWeight.bold,
                      textOne: 'I already have an account!',
                      textTwo: ' Sign In'),
                ),
              )
            ],
          ),
        ));
  }

  onClickSignIn() {
    setState(() {
      Navigator.of(context).pop(true);
    });
  }
}
