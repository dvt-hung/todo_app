import 'package:flutter/material.dart';

class AddNotescreen extends StatefulWidget {
  const AddNotescreen({Key? key}) : super(key: key);

  @override
  State<AddNotescreen> createState() => _AddNotescreenState();
}

class _AddNotescreenState extends State<AddNotescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('$AddNotescreen'),
    );
  }
}
