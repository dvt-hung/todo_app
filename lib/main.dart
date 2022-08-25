import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:noteapp/pages/home_page/home_page.dart';

import 'package:noteapp/pages/sign_in/sign_in_page.dart';
=======
import 'package:noteapp/pages/login/test_page.dart';
>>>>>>> fa65cdc88a1e0ed7e14ca3327a2c10f925855a38

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
<<<<<<< HEAD
      home: const HomePage(),
=======
      home: LoginPage(),
>>>>>>> fa65cdc88a1e0ed7e14ca3327a2c10f925855a38
    );
  }
}
