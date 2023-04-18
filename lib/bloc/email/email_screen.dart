import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks/bloc/email/email.dart';
import 'package:tasks/utilities/alert_utils.dart';
import 'package:tasks/utilities/app_ui_dimens.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:tasks/utilities/validation_utils.dart';
import 'package:tasks/widgets/custom_button.dart';

import '../../utilities/common_utils.dart';
import '../../utilities/database_utils.dart';
import '../../utilities/routes.dart';
import '../../widgets/custom_dropdown_item.dart';
import '../../widgets/custom_textfield.dart';
import 'email_bloc.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController mDescController = TextEditingController();

  TextEditingController mDateTimeController = TextEditingController();
  String transactionStatus = "";

  @override
  void initState() {
    context.read<EmailBloc>().add(OnFormLoadEvent());
    getEmails();
    super.initState();
  }

  bool isEmailRecordsAvailable = false;

  getEmails() async {
    dynamic response = await DBProvider.db.getAllEmail();
    if (response is List<EmailRequest> && response.isNotEmpty) {
      setState(() {
        isEmailRecordsAvailable = true;
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    var fieldDesc = CustomTextField(
      controller: mDescController,
      prefixIcon: const Icon(Icons.description_outlined),
    );

    fieldDesc.validator = (arg) {
      return ValidationUtils.dynamicValidation(arg, "Description", context);
    };
    fieldDesc.hint = "Description";
    var fieldStatus = DropDownItem(
      "Transaction Status",
      onChange: (String value) {
        transactionStatus = value;
      },
      dropDownItems: const ["Success", "Pending", "Error"],
    );
    var fieldTime = CustomTextField(
      controller: mDateTimeController,
      prefixIcon: const Icon(Icons.date_range),
    );
    fieldTime.hint = "DateTime";
    fieldTime.readOnly = true;
    fieldTime.validator = (arg) {
      return ValidationUtils.dynamicValidation(arg, "DateTime", context);
    };
    fieldTime.onTap = fetchDate;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Email",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<EmailBloc, EmailState>(
          builder: (context, state) {
            if (state is NewFormEmail) {
              mDateTimeController.clear();
              mDescController.clear();
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(AppUIDimens.paddingMedium),
                child: Form(
                    autovalidateMode: mode,
                    key: _formKey,
                    child: Column(
                      children: [
                        fieldDesc,
                        fieldStatus,
                        fieldTime,
                        const SizedBox(height: 60),
                        CustomButton(
                          label: "Submit",
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<EmailBloc>().add(OnEmailSaveEvent(
                                  email: EmailRequest(
                                      transactionDatetime:
                                          mDateTimeController.text,
                                      transactionDesc: mDescController.text,
                                      transactionStatus: transactionStatus)));
                            } else {
                              setState(() {
                                mode = AutovalidateMode.always;
                              });
                            }
                          },
                        ),
                        if (isEmailRecordsAvailable) const SizedBox(height: 30),
                        if (isEmailRecordsAvailable)
                          CustomButton(
                            label: "Go to Email list",
                            onPressed: () async{
                              dynamic response = await Navigator.pushNamed(
                                  context, Routes.emailList);
                              context.read<EmailBloc>().add(OnFormLoadEvent());
                              getEmails();
                            },
                          )
                      ],
                    )),
              ));
            } else if (state is EmailError) {
              return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error.message!,
                        style: Theme.of(context).textTheme.headline1),
                  ]);
            } else if (state is EmailSaved) {
              return Padding(
                  padding: const EdgeInsets.all(AppUIDimens.paddingMedium),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.done_all_rounded,
                          color: Colors.green,
                          size: 40,
                        ),
                        const Text("Email saved successful!"),
                        const SizedBox(height: 30),
                        CustomButton(
                          label: "Add New",
                          onPressed: () {
                            context.read<EmailBloc>().add(OnFormLoadEvent());
                          },
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          label: "Go to Email List ",
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.emailList);
                          },
                        )
                      ]));
            } else if (state is EmailLoading) {
              return CommonUtils.loadingWidget();
            } else {
              return CommonUtils.loadingWidget();
            }
          },
        ));
  }

  Future<void> fetchDate()async {
    DatePicker.showDatePicker(context,
        dateFormat: "yyyy-MM-dd",
        pickerTheme: DateTimePickerTheme(
            itemHeight: 55,
            itemTextStyle: const TextStyle(fontSize: 17, color: Colors.black),
            cancelTextStyle: const TextStyle(fontSize: 16, color: Colors.red),
            confirmTextStyle: TextStyle(
                fontSize: 16, color: Theme.of(context).primaryColor)),
        onConfirm: (dateTime, List<int> index) {
          mDateTimeController.text = DateFormat('yyyy-MM-dd').format(dateTime);
        });
  }
}
