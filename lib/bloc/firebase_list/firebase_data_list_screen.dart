import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/firebase_list/argument.dart';
import 'package:tasks/bloc/firebase_list/firebase_item.dart';
import 'package:tasks/bloc/firebase_list/firebase_list_bloc.dart';

import '../../utilities/app_ui_dimens.dart';
import '../../utilities/common_utils.dart';
import '../../utilities/firebase_utils.dart';
import '../firebase/firebase_request.dart';

class FirebaseDataListScreen extends StatefulWidget {
  final Argument args;

  const FirebaseDataListScreen({Key? key, required this.args})
      : super(key: key);

  @override
  State<FirebaseDataListScreen> createState() => _FirebaseDataListScreenState();
}

class _FirebaseDataListScreenState extends State<FirebaseDataListScreen> {
  @override
  void initState() {
    createAnonymous();

    super.initState();
  }

  var userCredential;

  createAnonymous() async {
    try {
      userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.${userCredential.user!.uid}");
      context
          .read<FirebaseListBloc>()
          .add(OnFetchFirebaseEvent(userId: userCredential.user!.uid));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Firebase Reports",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(child: BlocBuilder<FirebaseListBloc, FirebaseListState>(
        builder: (context, state) {
          if (state is FirebaseListLoaded) {
            return listReportWidget(state.firebaseList);
          } else if (state is FirebaseListError) {
            return errorWidget(state);
          } else if (state is FirebaseListLoading) {
            return CommonUtils.loadingWidget();
          } else {
            return CommonUtils.loadingWidget();
          }
        },
      )),
    );
  }

  errorWidget(FirebaseListError state) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.error.toString()),
        ]);
  }

  listReportWidget(List<FirebaseRequest> list) {
    if (list.isNotEmpty) {
      return ListView.separated(
          padding: const EdgeInsets.symmetric(
              horizontal: AppUIDimens.paddingXXSmall),
          itemBuilder: (context, index) {
            return FirebaseItem(item: list[index],onTap: (){
              CommonUtils.showFirebaseBottomSheet(context,firebaseItem: list[index]);
            },);
          },
          separatorBuilder: (context, index) => Container(),
          itemCount: list.length);
    } else {
      return const Center(child: Text("No Records Found"));
    }
  }
}
