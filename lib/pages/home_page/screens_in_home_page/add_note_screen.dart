import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  PlatformFile? imageNote;

  // Select image
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      imageNote = result.files.first;
    });
  }

  // Add note
  void addNewNote() {
    String title = _addTitle.text;
    String content = _addContent.text;

    if (title.isEmpty || content.isEmpty || imageNote == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        Dialogs.mySnackBar("Dữ liệu đang bị bỏ trống"),
      );
    } else {
      NoteModel note = NoteModel();
      note.title = title;
      note.content = content;
      note.uuid = Singleton().user!.uuid;
      note.create = Timestamp.now();
      // Call API
      Api_Service.addNewNote(
        context,
        note,
        imageNote!,
        (result) {
          if (result) {
            _addTitle.clear();
            _addContent.clear();
            imageNote = null;
            ScaffoldMessenger.of(context).showSnackBar(
              Dialogs.mySnackBar("Đã thêm thành công"),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              Dialogs.mySnackBar("Không thành công"),
            );
          }
        },
      );
    }
  }

  final TextEditingController _addTitle = TextEditingController();
  final TextEditingController _addContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [headerAddNote(context), bodyAddNote(context)],
          ),
        ),
      )),
    );
  }

//HEADER_ADDNOTE
  Container headerAddNote(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColor.secondColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TextRichcomponent(
                colorTwo: AppColor.thirdColor,
                colorOne: AppColor.thirdColor,
                textOne: 'Add a note',
                textTwo: '\nWrite something',
                fontSize: 22),
            //
          ],
        ),
      ),
    );
  }

//BODY_ADDNOTE
  Positioned bodyAddNote(BuildContext context) {
    return Positioned(
      top: 90,
      left: 0,
      right: 0,
      child: Container(
        height: 800,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: AppColor.thirdColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
//INPUT IMAGE
              imageNote != null
                  ? ClipOval(
                      child: Image.file(File(imageNote!.path!),
                          width: 90, height: 90, fit: BoxFit.cover),
                    )
                  : Image.asset(
                      "asset/photo.png",
                      height: 90,
                      width: 90,
                    ),
//TEXTFIELD TITLE
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _addTitle,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
//TEXTFIELD CONTENT
              SizedBox(
                height: 100.0,
                child: TextField(
                  maxLines: 10,
                  controller: _addContent,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
//BUTTON IMAGE
              Bunttoncomponent(
                  textButton: 'Select Image',
                  fontSize: 22,
                  colorText: AppColor.thirdColor,
                  colorButton: AppColor.secondColor,
                  onTap: () {
                    selectFile();
                  }),
              const SizedBox(
                height: 20,
              ),
//BUTTON SUCCESS
              Bunttoncomponent(
                  textButton: 'Confirm',
                  fontSize: 22,
                  colorText: AppColor.thirdColor,
                  colorButton: AppColor.blueColor,
                  onTap: () {
                    addNewNote();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
