import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture as File;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Choice'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text('Gallary'),
                    onTap: _openGallary(context),
                  ),
                  const Padding(padding: EdgeInsets.all(8)),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: _openCamera(context),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final maxLines = 5;
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
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColor.secondColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      TextRichcomponent(
                          colorTwo: AppColor.thirdColor,
                          colorOne: AppColor.thirdColor,
                          textOne: 'Add Note',
                          textTwo: '\nWrite something',
                          fontSize: 20),
                      Icon(
                        Icons.note,
                        color: AppColor.thirdColor,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 0,
                right: 0,
                child: Container(
                  height: 5000,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //_decideImageView(),

                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: TextField(
                            controller: _addNotetitle,
                            decoration: const InputDecoration(
                              labelText: 'Enter',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _addContent,
                          decoration: const InputDecoration(
                            labelText: 'Enter',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                        Bunttoncomponent(
                            textButton: 'Success',
                            fontSize: 22,
                            colorText: AppColor.thirdColor,
                            colorButton: AppColor.blueColor,
                            onTap: () {}),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text('data');
    } else {
      return Image.file(
        imageFile,
        width: 300,
        height: 300,
      );
    }
  }
}
