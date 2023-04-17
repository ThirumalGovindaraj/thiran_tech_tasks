import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/utilities/app_ui_dimens.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {required this.label,
      this.margin =
          const EdgeInsets.only(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
      this.arrowVisible = true,
      this.outlineButton = false,
      this.onPressed,
      this.icon = const Icon(
        Icons.ac_unit,
        color: Colors.transparent,
      ),
      this.paddingRightValue: 0.0});

  Widget icon;
  String label = "";

  Color borderColor = Colors.transparent;
  double height = AppUIDimens.buttonHeight;
  EdgeInsets margin;

  double paddingRightValue;

  double width = double.infinity;
  final double radius = 7.5;

  Color textColor = Colors.white;
  Color? buttonColor;
  double fontSize = 16.0;

  bool enabled = true;
  bool outlineButton;
  bool visible = true;
  bool arrowVisible = true;
  VoidCallback? onPressed = () {};

  @override
  Widget build(BuildContext context) {
    Widget viewDetailButton =
        Stack(alignment: Alignment.centerRight, children: [
      GestureDetector(
          onTap: onPressed,
          child: Container(
              alignment: Alignment.center,
              // margin: margin,
              padding: EdgeInsets.only(
                  top: 11, bottom: 11, right: paddingRightValue),
              decoration: BoxDecoration(
                  color: buttonColor ?? Theme.of(context).primaryColor,
                  border: Border.all(
                      color: buttonColor ?? Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(radius)),
              child: Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: fontSize, color: Colors.white)))),
      if (arrowVisible)
        const Padding(
            padding: EdgeInsets.only(right: AppUIDimens.paddingXXXLarge),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 15,
            )),
    ]);

    if (outlineButton) {
      viewDetailButton = OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius))),
        ),
        onPressed: onPressed,
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: fontSize, color: Theme.of(context).primaryColor)),
      );
    }

    return SizedBox(
        width: width,
        child: Container(
          decoration: BoxDecoration(
              color: outlineButton ? null : Theme.of(context).primaryColor,
              border: Border.all(
                  color: buttonColor ?? Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(radius)),
          height: height,
          margin: margin,
          child: viewDetailButton,
        ));
  }
}
