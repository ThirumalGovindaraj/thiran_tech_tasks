import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/utilities/database_utils.dart';

import '../../utilities/app_ui_dimens.dart';
import 'email.dart';
import 'email_bloc.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({Key? key}) : super(key: key);

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  List<EmailRequest> emailList = [];

  @override
  void initState() {
    context.read<EmailBloc>().add(PageOnLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email List",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: BlocBuilder<EmailBloc, EmailState>(
          builder: (context, state) {
            if (state is EmailLoaded) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppUIDimens.paddingXXSmall),
                  itemBuilder: (context, index) {
                    return Card(
                        margin: const EdgeInsets.all(AppUIDimens.paddingXSmall),
                        child: Padding(
                            padding:
                                const EdgeInsets.all(AppUIDimens.paddingSmall),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.emailList[index].transactionDesc!),
                                Text(state
                                    .emailList[index].transactionDatetime!),
                                Text(state.emailList[index].transactionStatus!)
                              ],
                            )));
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: state.emailList.length);
            } else if (state is EmailError) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error.message!,
                            style: Theme.of(context).textTheme.headline1)
                      ]));
            } else if (state is EmailLoading) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [CircularProgressIndicator()]));
            } else {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [CircularProgressIndicator()]));
            }
          },
        ),
      ),
    );
  }
}
