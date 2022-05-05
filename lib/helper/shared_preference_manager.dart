import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  saveLoginStatus(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', isLogin);
  }

  Future<bool?> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    return isLogin;
  }

  Future<void> removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    prefs.clear();
  }
}
