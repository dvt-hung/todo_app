import 'package:flutter/material.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Api_Service.addUser();
          },
          child: Text(
            "Test",
            style: TextStyle(color: AppColors.branchColor),
          ),
        ),
      ),
    );
  }
}
