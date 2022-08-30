import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/service/api_service.dart';
import 'package:noteapp/utils/app_colors.dart';
import 'package:noteapp/utils/app_styles.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/singleton.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> listNote = [];
  // Get list note
  Future getList() async {
    await Api_Service.getNote(
      Singleton().user!.uuid!,
      (notes) {
        listNote.clear();
        List<dynamic> listTemp = notes;
        for (var element in listTemp) {
          listNote.add(NoteModel.fromJson(element));
        }

// Delete the file
      },
      // Catch Error
      (e) {
        ScaffoldMessenger.of(context).showSnackBar(Dialogs.mySnackBar(e));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: FutureBuilder(
        future: getList(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: listNote.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(listNote[index].uuid!),
                    background: Container(
                      margin: const EdgeInsets.only(right: 30),
                      alignment: AlignmentDirectional.centerEnd,
                      child: const Icon(
                        Icons.delete,
                        color: AppColor.redColor,
                        size: 30,
                      ),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) async {
                      Dialogs.showProgressDialog(context);
                      await Api_Service.deleteNote(listNote[index], (msg) {});
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listNote[index].title!,
                                style: AppStyles.h1,
                              ),
                              SizedBox(
                                width: size.width - 120,
                                child: Text(
                                  listNote[index].content!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                            listNote[index].image!,
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
