import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/preferences.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  UserModel? user;
  Preferences? prefs;

  factory Singleton() {
    return _singleton;
  }
  logOut() async {
    await FirebaseAuth.instance.signOut();
    user = null;
  }

  Singleton._internal();

  initial() async {
    prefs = Preferences();
  }
}
