import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/utils/app_colors.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => AddNoteScreenState();
}

class AddNoteScreenState extends State<AddNoteScreen> {
  PlatformFile? imageNote;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      imageNote = result.files.first;
    });
  }

  late File imageFile;

  Future pickGallary() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('$e Faild');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      // setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('$e Faild');
    }
  }

  _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text('Gallary'),
                    onTap: () => pickGallary(),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: const Text('Camera'),
                    onTap: () => pickCamera(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final TextEditingController _addNotetitle = TextEditingController();
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
            // GestureDetector(
            //   onTap: () => pickGallary(),
            //   child: Container(
            //     height: 45.0,
            //     width: 45.0,
            //     decoration: BoxDecoration(
            //       color: AppColor.redColor,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: const Icon(
            //       Icons.note,
            //       color: AppColor.thirdColor,
            //       size: 35,
            //     ),
            //   ),
            // )
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
//               image != null
//                   ? ClipOval(
//                       child: Image.file(image!,
//                           width: 140, height: 140, fit: BoxFit.cover),
//                     )
//                   : const FlutterLogo(
//                       size: 140,
//                     ),
//TEXTFIELD TITLE
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: _addNotetitle,
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
                    _showChoiceDialog(context);
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
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
