import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/utils/app_colors.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({Key? key}) : super(key: key);

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  File? image;

  Future pickGallary() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('$e Failed');
    }
  }

  Future pickCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('$e Failed');
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

  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double heightOfPhone = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.thirdColor,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: heightOfPhone * 0.3,
                  color: AppColor.secondColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 115.0,
                              width: 115.0,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.thirdColor),
                              child: image != null
                                  ? ClipOval(
                                      child: Image.file(image!,
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover),
                                    )
                                  : const FlutterLogo(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              _showChoiceDialog(context);
                            },
                            child: const Text('Edit picture')),
                      ]),
                ),
                Container(
                  width: double.infinity,
                  height: heightOfPhone * 0.55,
                  color: AppColor.thirdColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        //UPDATE PAGE
                        const TextRichcomponent(
                          colorOne: AppColor.secondColor,
                          textOne: 'Update note',
                          textTwo: '',
                          fontSize: 24,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            controller: updateTitle,
                            height: 50,
                            color: AppColor.secondColor,
                            labelText: 'Title'),
                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            maxLine: 10,
                            controller: updateContent,
                            height: 200,
                            color: AppColor.secondColor,
                            labelText: 'Content'),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //BUTTON BACK
                    Bunttoncomponent(
                      onTap: () {
                        Navigator.of(context).pop(true);
                      },
                      width: 100,
                      textButton: 'Back',
                      colorText: AppColor.thirdColor,
                      colorButton: AppColor.greyColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    //UPDATE
                    Bunttoncomponent(
                      onTap: () {},
                      width: 100,
                      textButton: 'Update',
                      colorText: AppColor.thirdColor,
                      colorButton: AppColor.secondColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
