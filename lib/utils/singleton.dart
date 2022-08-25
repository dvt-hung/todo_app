import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/utils/preferences.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();
  UserModel? user;
  Preferences? prefs;

  factory Singleton() {
    return _singleton;
  }
  Singleton._internal();

  initial() async {
    prefs = Preferences();
  }
}
