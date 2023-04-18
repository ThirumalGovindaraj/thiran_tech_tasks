import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasks/bloc/email/email.dart';
import 'package:tasks/bloc/firebase/firebase_request.dart';

class FirebaseUtils {
  FirebaseUtils._();

  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<String> uploadPic(File image) async {
    Reference ref = _storage.ref().child("image${DateTime.now()}");
    UploadTask uploadTask = ref.putFile(image);
    var reference = uploadTask.storage.ref();
    return await reference.getDownloadURL();
  }

  static Future<dynamic> uploadPicture(File image) async {
    TaskSnapshot snapshot = await FirebaseStorage.instance
        .ref("image${DateTime.now()}")
        .putFile(File(image.path));
    if (snapshot.state == TaskState.success) {
      print("Image uploaded Successful");
      return await snapshot.ref.getDownloadURL();
    } else if (snapshot.state == TaskState.running) {
      // Show Prgress indicator
    } else if (snapshot.state == TaskState.error) {
      // Handle Error Here
    }
  }

  static Future<dynamic> saveBugReport(
      FirebaseRequest request, String userId) async {
    try {
      final userProfileRef = _db.collection("bugs").doc();
      await userProfileRef.set(request.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<dynamic> getBugReport(String userId) async {
    List<FirebaseRequest> emails = [];
    try {
      await _db.collection("bugs").where("uid", isEqualTo: userId).get().then(
        (querySnapshot) {
          debugPrint("Successfully completed");
          for (var docSnapshot in querySnapshot.docs) {
            debugPrint('${docSnapshot.id} => ${docSnapshot.data()}');
            emails.add(FirebaseRequest.fromJson(docSnapshot.data()));
          }
          return emails;
        },
        onError: (e) => print("Error completing: $e"),
      );
      // final userProfileRef = _db.collection("bugs").doc(userId);
      // await userProfileRef.set(request.toJson(), SetOptions(merge: true));
      return emails;
    } catch (e) {
      return e.toString();
    }
  }
}
