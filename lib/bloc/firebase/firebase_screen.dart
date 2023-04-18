import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasks/bloc/firebase_list/argument.dart';
import 'package:tasks/utilities/common_utils.dart';
import 'package:tasks/utilities/firebase_utils.dart';

import '../../utilities/app_ui_dimens.dart';
import '../../utilities/routes.dart';
import '../../utilities/validation_utils.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'firebase_bloc.dart';
import 'firebase_request.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  @override
  void initState() {
    context.read<FirebaseBloc>().add(OnFormLoadEvent());
    createAnonymous();
    askPermissionForCameraStorage();
    super.initState();
  }

  getData() {}

  askPermissionForCameraStorage() async {
    await CommonUtils.permissionRequest(Permission.storage);
    await CommonUtils.permissionRequest(Permission.camera);
  }

  var userCredential;

  createAnonymous() async {
    try {
      userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.${userCredential.user!.uid}");
     // await FirebaseUtils.getBugReport(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;
  TextEditingController mTitleController = TextEditingController();
  TextEditingController mDescController = TextEditingController();
  TextEditingController mLocationController = TextEditingController();
  TextEditingController mAttachmentController = TextEditingController();
  final picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rise Ticket",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<FirebaseBloc, FirebaseState>(
        builder: (context, state) {
          if (state is NewFormFirebase) {
            return firebaseEntryForm();
          } else if (state is FirebaseError) {
            return errorWidget(state);
          } else if (state is FirebaseSaved) {
            return firebaseSaved();
          } else if (state is FirebaseLoading) {
            return CommonUtils.loadingWidget();
          } else {
            return CommonUtils.loadingWidget();
          }
        },
      ),
    );
  }

  firebaseEntryForm() {
    var fieldTitle = CustomTextField(
      controller: mTitleController,
      prefixIcon: const Icon(Icons.description_outlined),
    );
    fieldTitle.hint = "Problem Title";
    fieldTitle.validator = (arg) {
      return ValidationUtils.dynamicValidation(arg, "Problem Title", context);
    };

    var fieldDesc = CustomTextField(
      controller: mDescController,
      prefixIcon: const Icon(Icons.description_outlined),
    );
    fieldDesc.hint = "Description";
    fieldDesc.validator = (arg) {
      return ValidationUtils.dynamicValidation(arg, "Description", context);
    };

    var fieldLocation = CustomTextField(
      controller: mLocationController,
      prefixIcon: const Icon(Icons.location_on_outlined),
    );
    fieldLocation.hint = "Location";
    fieldLocation.validator = (arg) {
      return ValidationUtils.dynamicValidation(arg, "Location", context);
    };
    /*fieldLocation.onTap = () async {

    };*/

    var fieldAttachment = CustomTextField(
      controller: mTitleController,
      prefixIcon: const Icon(Icons.attach_file_rounded),
    );
    fieldAttachment.hint = "Attachment";

    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(AppUIDimens.paddingMedium),
      child: Form(
          autovalidateMode: mode,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldTitle,
              fieldDesc,
              fieldLocation,
              const SizedBox(
                height: 20,
              ),
              if (image != null)
                SizedBox(
                    height: 130,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Center(
                            child: Image.file(File(image!.path), height: 100)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.cancel_rounded,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                image = null;
                                setState(() {});
                              },
                            )
                          ],
                        )
                      ],
                    )),
              if (image == null)
                const SizedBox(height: 30, child: Text("Select Image")),
              if (image == null)
                CustomButton(
                  label: "Image from Gallery",
                  arrowVisible: false,
                  onPressed: () async {
                    image = (await ImagePicker()
                        .pickImage(source: ImageSource.gallery)) as XFile;
                    setState(() {});
                  },
                ),
              if (image == null)
                const SizedBox(
                  height: 20,
                  child: Center(child: Text("-------- OR ---------")),
                ),
              if (image == null)
                CustomButton(
                  label: "Image from Camera",
                  arrowVisible: false,
                  onPressed: () async {
                    image = (await ImagePicker()
                        .pickImage(source: ImageSource.camera)) as XFile;
                    setState(() {});
                  },
                ),
              const SizedBox(height: 30),
              CustomButton(
                label: "Submit",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    AndroidDeviceInfo androidInfo =
                        await DeviceInfoPlugin().androidInfo;
                    context.read<FirebaseBloc>().add(PageOnLoadEvent());
                    context.read<FirebaseBloc>().add(OnFirebaseSaveEvent(
                        firebase: FirebaseRequest(
                            title: mTitleController.text,
                            description: mDescController.text,
                            date: DateFormat("dd-MM-yyyy HH:mm:ss")
                                .format(DateTime.now()),
                            attachment: image != null ? image!.path : "",
                            location: mLocationController.text),
                        userId: userCredential.user.uid));
                  } else {
                    setState(() {
                      mode = AutovalidateMode.always;
                    });
                  }
                },
              ),
            ],
          )),
    ));
  }

  errorWidget(FirebaseError state) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.error.toString()),
        ]);
  }

  firebaseSaved() {
    _clearFields();
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
              const Text("Report sent successfully!"),
              const SizedBox(height: 30),
              CustomButton(
                label: "New Report",
                onPressed: () {
                  context.read<FirebaseBloc>().add(OnFormLoadEvent());
                },
              ),
              const SizedBox(height: 30),
              CustomButton(
                label: "Go To Report Detail Screen",
                onPressed: () {
                  // context.read<FirebaseBloc>().add(OnFormLoadEvent());
                  Navigator.pushNamed(context, Routes.firebaseList,
                      arguments: Argument(userCredential.user!.uid));
                },
              ),
            ]));
  }

  _clearFields() {
    mLocationController.clear();
    mDescController.clear();
    mTitleController.clear();
    image = null;
  }
}
