import 'package:flutter/material.dart';
import 'package:noteapp/components/buntton_component.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/components/textfield_component.dart';
import 'package:noteapp/utils/app_colors.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
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
                  height: heightOfPhone * 0.2,
                  color: AppColor.secondColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 105.0,
                              width: 105.0,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.thirdColor),
                              child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: FlutterLogo()),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Edit picture'),
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
                    Bunttoncomponent(
                      onTap: () {},
                      width: 100,
                      textButton: 'Back',
                      colorText: AppColor.thirdColor,
                      colorButton: AppColor.greyColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
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
