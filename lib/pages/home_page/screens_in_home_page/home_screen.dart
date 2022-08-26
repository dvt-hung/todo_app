import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_color.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildListView(),
    );
  }

  Widget buildListView() => GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GridTile(
            child: Ink.image(
              image: const AssetImage('asset/meme2.jpg'),
              fit: BoxFit.cover,
            ),
            footer: Container(
              padding: EdgeInsets.all(12),
              child: Text(
                item,
                style: TextStyle(
                    color: AppColor.redColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
            ),
          );
        },
      );
}
