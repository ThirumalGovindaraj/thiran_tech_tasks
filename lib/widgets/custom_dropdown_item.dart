import 'package:flutter/material.dart';
import '../utilities/common_utils.dart';
import '../utilities/validation_utils.dart';
import '/utilities/app_ui_dimens.dart';
import 'custom_textfield.dart';

class DropDownItem extends StatefulWidget {
  @override
  DropDownItemState createState() => DropDownItemState();
  final ValueChanged<String> onChange;

  // final String defValue;
  final bool hideRulerLine;
  final List<String> dropDownItems;

  // final ValueChanged<String> validator;
  final String name;

  DropDownItem(
    this.name, {
    required this.onChange,
    // required this.defValue,
    required this.dropDownItems,
    this.hideRulerLine: false,
  });
}

class DropDownItemState extends State<DropDownItem> {
  String? value;

  @override
  Widget build(BuildContext context) {
    final field = CustomTextField(
      controller: TextEditingController(),
      prefixIcon: const Padding(
          padding: EdgeInsets.all(AppUIDimens.paddingSmall),
          child: Icon(Icons.monetization_on_outlined)),
      textInputType: TextInputType.text,
      margin: EdgeInsets.zero,
    );
    field.validator = (arg) {
      if (value == null) {
        return ValidationUtils.dynamicValidation(arg, widget.name, context);
      }
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: [
            Padding(padding:const EdgeInsets.only(top: 5),child:field),
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 7),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                        isExpanded: true,
                        iconSize: 30,
                        hint: Row(children: [
                          const SizedBox(
                            width: AppUIDimens.paddingXXXLarge,
                          ),
                          Text(value == null ? "Select ${widget.name}" : value!,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: value == null ? null : Colors.black)),
                        ]),
                        items: widget.dropDownItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(children: [
                              const SizedBox(
                                width: AppUIDimens.paddingXXXLarge,
                              ),
                              Text(value,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black))
                            ]),
                          );
                        }).toList(),
                        onChanged: (arg) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          value = arg!;
                          widget.onChange(arg);
                        }))),
          ],
        ),
      ],
    );
  }
}
