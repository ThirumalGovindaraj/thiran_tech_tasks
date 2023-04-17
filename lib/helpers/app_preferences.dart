import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final instance = AppPreferences._();

  AppPreferences._();

  static const _pushTimeKey = "push_time";
  static const _fcmTokenKey = "fcm_token";

  String? _pushTime;
  String? _fcmToken;

  String? get pushTime => _pushTime;

  String? get fcmToken => _fcmToken;

  init() async {
    _pushTime = await AppPreferences.getEmailPushTime();
    _fcmToken = await AppPreferences.getNotificationToken();
  }

  static Future<String?> getEmailPushTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? latLong = localStorage.getString(_pushTimeKey);
    return latLong;
  }

  static Future<void> setLogoutTime(String time) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString(_pushTimeKey, time);
    await AppPreferences.instance.init();
  }

  static Future<String?> getNotificationToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? latLong = localStorage.getString(_fcmTokenKey);
    return latLong;
  }

  static Future<void> setNotificationToken(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString(_fcmTokenKey, token);
    await AppPreferences.instance.init();
  }
}
