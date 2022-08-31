import 'package:flutter/material.dart';
import 'package:noteapp/components/text_rich_component.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/pages/home_page/update_note/update_note_page.dart';
import 'package:noteapp/utils/app_colors.dart';

class DetailNotePage extends StatefulWidget {
  const DetailNotePage({Key? key, required this.note}) : super(key: key);

  final NoteModel note;

  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  @override
  Widget build(BuildContext context) {
    double heightOfPhone = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: onClickedIconBack,
              icon: const Icon(Icons.arrow_back_outlined),
              iconSize: 30,
              color: AppColor.secondColor,
            ),
            backgroundColor: AppColor.thirdColor,
            actions: [
              Center(
                child: GestureDetector(
                  child: const Text(
                    'Update',
                    style: TextStyle(
                        color: AppColor.secondColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: onClickedIconUp,
                ),
              ),
              IconButton(
                onPressed: onClickedIconUp,
                icon: const Icon(Icons.edit),
                color: AppColor.secondColor,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: AppColor.thirdColor,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: heightOfPhone * 0.14,
                        width: heightOfPhone * 0.14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.fifColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextRichcomponent(
                        textOne: 'Title: ${widget.note.title}',
                        textTwo:
                            '\nDate: ${widget.note.create?.toDate().toString()}',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.thirdColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColor.greyColor,
                              blurRadius: 7,
                            ),
                          ]),
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("aa"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onClickedIconUp() {
    setState(() {
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const UpdateNotePage()));
    });
  }

  onClickedIconBack() {
    setState(() {
      Navigator.of(context).pop(true);
    });
  }
}
