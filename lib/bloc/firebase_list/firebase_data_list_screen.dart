import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/firebase_list/firebase_item.dart';
import 'package:tasks/bloc/firebase_list/firebase_list_bloc.dart';

import '../../utilities/common_utils.dart';
import '../firebase/firebase_request.dart';

class FirebaseDataListScreen extends StatefulWidget {
  const FirebaseDataListScreen({Key? key}) : super(key: key);

  @override
  State<FirebaseDataListScreen> createState() => _FirebaseDataListScreenState();
}

class _FirebaseDataListScreenState extends State<FirebaseDataListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FirebaseListBloc, FirebaseListState>(
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
      ),
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
          itemBuilder: (context, index) {
            return FirebaseItem(item: list[index]);
          },
          separatorBuilder: (context, index) => Container(),
          itemCount: list.length);
    } else {
      return const Center(child: Text("No Records Found"));
    }
  }
}
