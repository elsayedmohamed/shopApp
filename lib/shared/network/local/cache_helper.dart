import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/reuseable.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences?.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        NavigateAndFinsh(context: context, screen: Login_Screen());
      }
    });
  }
}
