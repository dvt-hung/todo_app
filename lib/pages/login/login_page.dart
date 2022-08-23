import 'package:flutter/material.dart';
import 'package:noteapp/service/api_service.dart';

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
            Api_Service.registerEmail("hungdiep2@gmail.com", "123456", (msg) {
              print(msg);
            });
          },
          child: const Text(
            "Test",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}
