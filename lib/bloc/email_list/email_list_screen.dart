import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/utilities/common_utils.dart';
import 'package:tasks/utilities/database_utils.dart';

import '../../utilities/app_ui_dimens.dart';
import '../../widgets/custom_button.dart';
import '../email/email.dart';
import '../email/email_bloc.dart';

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
    errorReportAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var errorReportButton = CustomButton(
      label: "Send Error Report",
      margin: const EdgeInsets.all(AppUIDimens.paddingMedium),
    );
    errorReportButton.buttonColor = Colors.red;
    errorReportButton.onPressed = () {
      String errorMsg = "";
      if (response is List<EmailRequest> && response.isNotEmpty) {
        for (EmailRequest request in response) {
          if (request.transactionStatus.toString() == "Error".toString()) {
            errorMsg =
                "$errorMsg\n\n Transaction Description: ${request.transactionDesc!}\n Transaction status: ${request.transactionStatus!}\n Date Time: ${request.transactionDatetime!}";
          }
        }
      }
      CommonUtils.sendEmail(body: errorMsg, subject: "ErrorReport");
    };
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Email List",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      floatingActionButton: isErrorReportAvailable ? errorReportButton : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: BlocBuilder<EmailBloc, EmailState>(
          builder: (context, state) {
            if (state is EmailLoaded) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppUIDimens.paddingXXSmall),
                  itemBuilder: (context, index) {
                    // errorReportAvailable(state.emailList);
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
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Container(
                                    height: 15,
                                    width: 15,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color:
                                            CommonUtils.getColorBasedOnStatus(
                                                state.emailList[index]
                                                    .transactionStatus!),
                                        // border: Border.all(color: Theme.of(context).primaryColor),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                  Text(
                                    state.emailList[index].transactionStatus!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: CommonUtils.getColorBasedOnStatus(
                                          state.emailList[index]
                                              .transactionStatus!),
                                    ),
                                  )
                                ])
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
              return CommonUtils.loadingWidget();
            } else {
              return CommonUtils.loadingWidget();
            }
          },
        ),
      ),
    );
  }

  bool isErrorReportAvailable = false;
  dynamic response;

  errorReportAvailable() async {
    response = await DBProvider.db.getAllEmail();

    if (response is List<EmailRequest> && response.isNotEmpty) {
      for (EmailRequest request in response) {
        if (request.transactionStatus.toString() == "Error".toString()) {
          isErrorReportAvailable = true;
          setState(() {});
        }
      }
    }
  }
}
