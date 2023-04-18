import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final instance = AppPreferences._();

  AppPreferences._();

  static const _pushTimeKey = "push_time";
  static const _fcmTokenKey = "fcm_token";
  static const _nextPageUrlKey = "next_page_url";
  static const _isLastPageKey = "is_last_page_key";

  String? _pushTime;
  String? _nextPageUrl;
  String? _fcmToken;
  bool? _isLastPage;

  String? get pushTime => _pushTime;

  bool? get isLastPage => _isLastPage;

  String? get nextPageUrl => _nextPageUrl;

  String? get fcmToken => _fcmToken;

  init() async {
    _pushTime = await AppPreferences.getEmailPushTime();
    _fcmToken = await AppPreferences.getNotificationToken();
    _nextPageUrl = await AppPreferences.getNextPageUrl();
    _isLastPage = await AppPreferences.getLastPage();
  }

  static Future<String?> getEmailPushTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? latLong = localStorage.getString(_pushTimeKey);
    return latLong;
  }

  static Future<void> setEmailPushTime(String time) async {
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

  static Future<String?> getNextPageUrl() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? latLong = localStorage.getString(_nextPageUrlKey);
    return latLong;
  }

  static Future<void> setNextPageUrl(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString(_nextPageUrlKey, token);
    await AppPreferences.instance.init();
  }

  static Future<bool?> getLastPage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? latLong = localStorage.getBool(_isLastPageKey)??false;
    return latLong;
  }

  static Future<void> setLastPage(bool isLastPage) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setBool(_isLastPageKey, isLastPage);
    await AppPreferences.instance.init();
  }
}
