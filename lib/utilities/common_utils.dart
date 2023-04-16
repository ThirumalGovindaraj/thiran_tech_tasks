import 'package:flutter/material.dart';
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
       return  GithubDetailScreen(item: repoItem);
     },
   );
  }
}
