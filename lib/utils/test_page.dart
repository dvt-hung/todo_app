import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  PlatformFile? file;
  String fileName = "No Select File";

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      file = result.files.first;
    });
  }

  // Future uploadFile() async {
  //   Dialogs.showProgressDialog(context);
  //   final pathStorage = "images/${file!.name}";
  //   final fileImage = File(file!.path!);
  //   final ref = FirebaseStorage.instance.ref().child(pathStorage);
  //   uploadTask = ref.putFile(fileImage);
  //   final snapshot = await uploadTask!.whenComplete(() => () {});
  //   final url = await snapshot.ref.getDownloadURL();
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            file == null ? Text(fileName) : Image.file(File(file!.path!)),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Upload File"),
              ),
            ),
            ElevatedButton(
              onPressed: selectFile,
              child: Text("Select File"),
            ),
            ElevatedButton(
              onPressed: () {
                NoteModel note = NoteModel();
                note.content = "Test add  2";
                note.uuid = Singleton().user!.uuid;
                note.create = Timestamp.now();
                Api_Service.uploadImageNote(context, file!, note, (e) {
                  if (e == true) {
                    print("OKE");
                  } else {
                    print("No");
                  }
                });
              },
              child: const Text("Add note"),
            ),
          ],
        ),
      ),
    );
  }
}
