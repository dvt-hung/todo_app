import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_dimens.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class UpdateInfoPage extends StatefulWidget {
  const UpdateInfoPage({Key? key}) : super(key: key);

  @override
  State<UpdateInfoPage> createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  UserModel user = Singleton().user!;
  PlatformFile? imageUser;
  // Select image
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    setState(() {
      imageUser = result.files.first;
    });
  }

  void updateInfo() async {
    print(user.image!);
    user.name = name_controller.text;
    user.phone = phone_controller.text;
    user.address = address_controller.text;

    Dialogs.showProgressDialog(context);
    await Api_Service.updateUser(user, imageUser, (result) {
      if (result) {
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
        Navigator.pop(context);
      }
    });
  }

  TextEditingController name_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController address_controller = TextEditingController();
  bool isUpdate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Singleton().user != null) {
      name_controller.text = Singleton().user!.name!;
      phone_controller.text = Singleton().user!.phone!;
      address_controller.text = Singleton().user!.address!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightOfPhone = MediaQuery.of(context).size.height;

    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
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
                  ))
            ],
          ),
          backgroundColor: AppColor.thirdColor,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  color: AppColor.secondColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            minRadius: 60,
                            child: imageUser == null
                                ? (user.image!.isEmpty
                                    ? const FlutterLogo(
                                        size: 60,
                                      )
                                    : Image.network(user.image!,
                                        width: 140,
                                        height: 140,
                                        fit: BoxFit.cover))
                                : Image.file(
                                    File(imageUser!.path!),
                                  )),
                        const SizedBox(
                          height: 10,
                        ),
                        isUpdate
                            ? GestureDetector(
                                onTap: selectFile,
                                child: const Text(
                                  'Update picture',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: AppDimens.text_size_16,
                                    color: AppColor.thirdColor,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ]),
                ),
                Container(
                  width: double.infinity,
                  color: AppColor.thirdColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        //UPDATE PAGE

                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            enable: isUpdate,
                            controller: name_controller,
                            height: 50,
                            color: AppColor.secondColor,
                            labelText: 'Name '),

                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            enable: isUpdate,
                            controller: phone_controller,
                            height: 50,
                            color: AppColor.secondColor,
                            labelText: 'Phone: '),
                        const SizedBox(
                          height: 20,
                        ),
                        Textfieldcomponent(
                            enable: isUpdate,
                            controller: address_controller,
                            height: 50,
                            color: AppColor.secondColor,
                            labelText: 'Address: '),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //UPDATE
                isUpdate
                    ? Bunttoncomponent(
                        onTap: updateInfo,
                        width: 200,
                        textButton: 'Update Information',
                        colorText: AppColor.thirdColor,
                        colorButton: AppColor.secondColor,
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
