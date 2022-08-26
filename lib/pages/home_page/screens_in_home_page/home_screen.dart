import 'package:flutter/material.dart';
import 'package:noteapp/utils/app_colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> items = [
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
    'Annnnnnnnnn',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.thirdColor,
      body: buildGridView(),
    );
  }

  Widget buildGridView() => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            title: Text(item),
            subtitle: Text('Subtitle $index'),
            onTap: () {
              print('$index');
            },
          );
        },
      );
}
