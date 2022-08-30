import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/pages/home_page/home_page.dart';
import 'package:noteapp/pages/home_page/screens_in_home_page/add_note_screen.dart';
import 'package:noteapp/pages/sign_in/sign_in_page.dart';
import 'package:noteapp/pages/sign_up/sign_up_page.dart';
import 'package:noteapp/utils/test_page.dart';
import 'package:noteapp/pages/home_page/update/update_note_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
    );
  }
}
