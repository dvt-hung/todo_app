import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = "hungdiep2345@gmail.com";
  var password = "123456789";

  UserModel userModel = UserModel(
    name: "Hung",
    uuid: "UUID",
    userId: "userID",
    email: "Email",
    phone: "Phone",
    address: "Address",
  );
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
                Api_Service.signIn(email, password, (e) {
                  print(e);
                });
              },
              child: const Text(
                "Sign in",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Api_Service.registerEmail(email, password, (e) {
                  // print(e);
                });
              },
              child: const Text(
                "Sign up",
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
                Api_Service.check();
              },
              child: const Text(
                "Check",
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
                Api_Service.updateUser(
                  userModel,
                  (e) {
                    print(e);
                  },
                );
              },
              child: const Text(
                "Add note",
                style: TextStyle(color: Colors.amber),
              ),
            ),
            TestRead(),
          ],
        ),
      ),
    );
  }
}

class TestRead extends StatelessWidget {
  const TestRead({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference ref = FirebaseFirestore.instance.collection("note");
    return FutureBuilder(
        future: ref.doc("35bpyRlS1iK4HFWMiDdN").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            print("Does not exist");
            return Text("Does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print("Content: ${data["content"]}");
            return Text("Content: ${data["content"]}");
          }
          return Text("Loading");
        });
  }
}
