import 'package:flutter/material.dart';
import 'package:tasks/utilities/app_ui_dimens.dart';
import 'package:tasks/widgets/custom_button.dart';
import 'package:http/http.dart' as http;

import '../../utilities/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var buttonEmail = CustomButton(
      label: "Email Screen",
      margin: const EdgeInsets.only(top: AppUIDimens.paddingMedium),
    );
    buttonEmail.onPressed = () {
      Navigator.pushNamed(context, Routes.email);
    };
    var buttonGithub = CustomButton(
      label: "Github Repositories",
      margin: const EdgeInsets.only(top: AppUIDimens.paddingMedium),
    );
    buttonGithub.onPressed = () {
      Navigator.pushNamed(context, Routes.github);
    };
    var buttonFirebase = CustomButton(
      label: "Rise Firebase Ticket",
      margin: const EdgeInsets.only(top: AppUIDimens.paddingMedium),
    );
    buttonFirebase.onPressed = () {
      Navigator.pushNamed(context, Routes.firebase);
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Interview Tasks",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
          padding: const EdgeInsets.all(AppUIDimens.paddingMedium),
          child: Column(
            children: [
              const Text("Use Case 1"),
              buttonEmail,
              const SizedBox(
                height: 20,
              ),
              const Text("Use Case 2"),
              buttonGithub,
              const SizedBox(
                height: 20,
              ),
              const Text("Use Case 3"),
              buttonFirebase
            ],
          )),
    );
  }
}
