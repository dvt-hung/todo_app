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

  Future<bool> isLogin() async {
    user = await prefs?.getUserPreference();
    bool isLogin = false;
    isLogin = await prefs!.getIsLogin() as bool;

    return isLogin;
  }

  logout() async {
    user = null;
    prefs!.setIsRLogin(false);
    prefs!.clear();
  }

  signInCompleted(UserModel user) async {
    prefs!.setIsRLogin(true);
    prefs!.setUserPreference(user);
  }
}
