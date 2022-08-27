import 'package:flutter/material.dart';

class CustomItem extends StatelessWidget {
  final String title;
  // final Timestamp date;
  final String content;

  const CustomItem({
    Key? key,
    required this.content,
    // required this.date,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        height: 200,
        width: 150,
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Text(
            //   // '$date'.toString(),
            //   style: const TextStyle(),
            // ),
            Text(
              content,
            ),
          ],
        ),
      ),
    );
  }
}
