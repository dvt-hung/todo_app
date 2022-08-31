import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/pages/home_page/home_page.dart';
import 'package:noteapp/pages/home_page/screens_in_home_page/add_note_screen.dart';
import 'package:noteapp/pages/sign_in/sign_in_page.dart';
import 'package:noteapp/utils/singleton.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Singleton().initial();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  Future<bool> checkIsLogIn() async {
    isLogin = await Singleton().isLogin();

    return isLogin;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLogIn();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLogin ? const HomePage() : const SignInPage(),
    );
  }
}
