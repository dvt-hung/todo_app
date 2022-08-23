import 'package:flutter/material.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = "hungdiep2@gmail.com";
  var password = "123456";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Api_Service.signIn(email, password);
              },
              child: const Text(
                "Sign in",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Api_Service.signOut();

              },
              child: const Text(
                "Sign out",
                style: TextStyle(color: Colors.amber),
              ),
            ),
            TextButton(
              onPressed: () {
                // Api_Service.getNote((e){
                //   List<dynamic> notes = e;
                //   notes.forEach((element) {
                //     List<NoteModel> noteModels = [];
                //     noteModels.add(element.date());
                //     print(noteModels[0].content);
                //   });
                // }, (){});
                Api_Service.addNewNote();
              },
              child: const Text(
                "Add note",
                style: TextStyle(color: Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
