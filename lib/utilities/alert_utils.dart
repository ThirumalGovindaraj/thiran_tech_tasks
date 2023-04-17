import 'package:flutter/material.dart';

class AlertUtils {
  AlertUtils._();

  static exitAlertWidget(BuildContext context,
      {String title = "",
      String body = "",
      String positiveText = "Yes",
      String negativeText = "No",
      bool barrierDismissible: false,
      VoidCallback? onPositivePress,
      VoidCallback? onNegativePress}) {
    // set up the button
    Widget positiveButton = TextButton(
      onPressed: onPositivePress,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: Theme.of(context).primaryColor,
          child: Text(
            positiveText,
            style: const TextStyle(color: Colors.white),
          )),
    );
    Widget negativeButton = TextButton(
      onPressed: onNegativePress,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          color: Theme.of(context).primaryColor,
          child: Text(
            negativeText,
            style: const TextStyle(color: Colors.white),
          )),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Text(
        body,
      ),
      actions: [
        if (onPositivePress != null) positiveButton,
        if (onNegativePress != null) negativeButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSampleAlertDialog(BuildContext context,
      {String title = "",
      String body = "",
      VoidCallback? viaWhatsApp,
      VoidCallback? reportViaMail}) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title,
            style:
                const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
        content: Text(body),
        actions: <Widget>[
          TextButton(
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      )
                    ])),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
