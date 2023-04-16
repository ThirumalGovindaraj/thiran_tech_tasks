import 'package:flutter/material.dart';

import '../../widgets/custom_textfield.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key}) : super(key: key);

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  TextEditingController mDescController = TextEditingController();
  TextEditingController mStatusController = TextEditingController();
  TextEditingController mDateTimeController = TextEditingController();

  // TextEditingController mController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var fieldDesc = CustomTextField(
      controller: mDescController,
    );
    var fieldStatus = CustomTextField(
      controller: mStatusController,
    );
    var fieldTime = CustomTextField(
      controller: mDateTimeController,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [fieldDesc, fieldStatus, fieldTime],
      ),
    );
  }
}
