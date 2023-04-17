import 'dart:convert';

import 'package:tasks/bloc/firebase/firebase_request.dart';
import 'package:tasks/helpers/app_preferences.dart';
import 'package:tasks/helpers/webservice_helper.dart';

class FirebaseRepository {
  FirebaseRepository();

  WebServiceHelper helper = WebServiceHelper();

  Future<dynamic> requestFCM(FirebaseRequest request) async {
    dynamic response = await helper.post("https://fcm.googleapis.com/fcm/send",
        body: jsonEncode({
          "content-available": 1,
          "registration_ids": [await AppPreferences.getNotificationToken()],
          "collapse_key": null,
          "notification": {"title": request.title, "body": request.description},
          "data": request.toJson(),
          "priority": 10
        }),
        headers: {
          "Authorization":
              'key=AAAAcNUXOOU:APA91bHW-kMj-zKljcfZxCve_jrcwVuiI6Xh3NAr15OH-kx-QwFBY3k3IuZX5JWDJC_MF5mn8GPz3RvSoolAcC0bIXVcUGH7kC6wLFnarOZuZJ5-_zfMCkisu-_iEPu5E8SK-HjhPTpN',
          "Content-Type": 'application/json'
        },
        isOAuthTokenNeeded: false);
    if (response["success"] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
