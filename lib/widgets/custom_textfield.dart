// import '/utilities/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    required this.controller,
    this.label = "",
    this.textInputType = TextInputType.text,
    this.iconVisibility = false,
    this.prefixIcon,
    this.margin =
        const EdgeInsets.only(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0),
    this.helperText = "",
    this.hint = "",
    this.readOnly = false,
    this.maxLines = 1,
    this.focusNode
  });

  TextCapitalization capitalization = TextCapitalization.none;
  int maxCount = 0;
  String label = "";
  String hint = "";
  String helperText = "";
  int maxLength = 50;
  int maxLines = 1;
  bool isSecuredText = false;
  bool autoFocus = false;
  FormFieldValidator<String> validator = (arg) {};
  TextInputAction keyBoardInputAction = TextInputAction.next;

  //FocusNode node = FocusNode();
  EdgeInsets margin;

  TextInputType textInputType = TextInputType.text;
  TextEditingController controller = TextEditingController();
  double fontSize = 15.0;
  bool iconVisibility = false;
  bool enableInteractiveSelection = true;
  bool enabled = true;
  bool readOnly = false;
  FocusNode? focusNode;

  void Function(String) onChanged = (a) {};
  void Function(String) onSubmited = (a) {};
  VoidCallback onTap = () {};

  String iconLabel = "";
  String iconImage = "assets/images/barcode_icon.png";
  EdgeInsets customPadding = EdgeInsets.zero;
  TextStyle style = const TextStyle();
  TextStyle readOlyStyle =  TextStyle(color: Colors.grey[600]);

  //TextStyle labelStyle;
  TextAlign textAlign = TextAlign.left;
  Widget? prefixIcon;

  Widget suffixIcon = const Icon(
    Icons.add,
    color: Colors.transparent,
  );
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.only(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0);

  // FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: customPadding,
        margin: margin,
        child: TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          focusNode: focusNode,
          controller: controller,
          textAlign: textAlign,
          keyboardType: textInputType,
          maxLength: null,
          obscuringCharacter: "*",
          enableInteractiveSelection: enableInteractiveSelection,
          enabled: enabled,
          autofocus: autoFocus,
          textCapitalization: capitalization,
          style: readOnly ? readOlyStyle : style,
          textInputAction: keyBoardInputAction,
          maxLines: maxLines,
          decoration: InputDecoration(
              errorMaxLines: 2,
              helperText: helperText.trim().isEmpty ? null : helperText,
              //isDense: true,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              labelStyle: const TextStyle(height: 1),
              hintStyle:
                  TextStyle(color: Colors.black.withOpacity(0.7)),
              //hintText: (hint != null) ? hint : label,
              //border: OutlineInputBorder(),
              // enabledBorder: UnderlineInputBorder( borderSide: new BorderSide(color: Colors.black.withOpacity(0.15))),
              contentPadding: const EdgeInsets.all(8),
              labelText: hint),
          obscureText: isSecuredText,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmited,
        ));
  }
}
