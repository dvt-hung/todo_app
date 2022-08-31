import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_dimens.dart';
import 'package:noteapp/utils/dialogs.dart';

class UpdateNotePage extends StatefulWidget {
  NoteModel note;
  UpdateNotePage({Key? key, required this.note}) : super(key: key);
  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  File? image;
  PlatformFile? imageNote;

  bool isUpdate = false;
  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateContent = TextEditingController();

  // Select image
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      imageNote = result.files.first;
    });
  }

  // Update Note
  void updateNote() async {
    Dialogs.showProgressDialog(context);
    widget.note.title = updateTitle.text;
    widget.note.content = updateContent.text;
    await Api_Service.updateNote(
      widget.note,
      imageNote,
      (result) {
        if (result) {
          setState(() {
            isUpdate = !isUpdate;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            Dialogs.mySnackBar("Cập nhật thành công"),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            Dialogs.mySnackBar("Cập nhật thất bại"),
          );
        }
      },
    );
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTitle.text = widget.note.title!;
    updateContent.text = widget.note.content!;
  }

  @override
  Widget build(BuildContext context) {
    double heightOfPhone = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    isUpdate = !isUpdate;
                  });
                },
                child: Text(
                  isUpdate ? "Cancel" : "Update",
                  style: const TextStyle(
                      color: AppColor.thirdColor,
                      fontSize: AppDimens.text_size_16),
                ),
              ),
            ],
            centerTitle: true,
            elevation: 0.0,
          ),
          backgroundColor: AppColor.thirdColor,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColor.secondColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                              child: ClipOval(
                                child: imageNote == null
                                    ? Image.network(widget.note.image!,
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.cover)
                                    : Image.file(
                                        File(imageNote!.path!),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isUpdate
                            ? GestureDetector(
                                onTap: selectFile,
                                child: const Text(
                                  'Edit picture',
                                  style: TextStyle(
                                    color: AppColor.thirdColor,
                                    fontSize: AppDimens.text_size_16,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: AppColor.thirdColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            enable: isUpdate,
                            controller: updateTitle,
                            height: 50,
                            color: AppColor.secondColor,
                            labelText: 'Title'),
                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            enable: isUpdate,
                            maxLine: 10,
                            controller: updateContent,
                            height: 200,
                            color: AppColor.secondColor,
                            labelText: 'Content'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                isUpdate
                    ? Row(
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
                            onTap: updateNote,
                            width: 100,
                            textButton: 'Update',
                            colorText: AppColor.thirdColor,
                            colorButton: AppColor.secondColor,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
