import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tasks/bloc/github/github_details_screen.dart';

class CommonUtils {
  CommonUtils._();

  static Map<String, String> parseLinkHeader(String input) {
    final out = <String, String>{};
    final parts = input.split(', ');
    for (final part in parts) {
      if (part[0] != '<') {
        throw const FormatException('Invalid Link Header');
      }
      final kv = part.split('; ');
      var url = kv[0].substring(1);
      url = url.substring(0, url.length - 1);
      var key = kv[1];
      key = key.replaceAll('"', '').substring(4);
      out[key] = url;
    }
    return out;
  }

  static showBottomSheet(BuildContext context, {dynamic repoItem}) async {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return GithubDetailScreen(item: repoItem);
      },
    );
  }

  static sendEmail(
      {String body = "",
      String subject = "",
      String recipients = "",
      String cc = "",
      String bcc = ""}) async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['thirumal773@gmail.com'],
      cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],
      attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  static Future<void> permissionRequest(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    if (!status.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [permission].request();
    }
  }


}
