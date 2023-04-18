import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks/bloc/firebase/firebase_request.dart';
import 'package:tasks/bloc/github/repo_detail_item.dart';
import 'package:tasks/utilities/app_ui_dimens.dart';

class FirebaseDetailScreen extends StatelessWidget {
  final FirebaseRequest item;

  const FirebaseDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("Problem Details")],
                      ),
                      Positioned(
                          // right: 10,

                          child: IconButton(
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }))
                    ],
                  )),
              if (item.attachment != null)
                Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                            imageUrl: item.attachment!,
                            placeholder: (context, url) =>
                                const Icon(Icons.account_circle),
                            width: 300))),
              const SizedBox(
                height: 30,
              ),
              RepoDetailItem(
                fieldName: "Problem Title",
                fieldValue: item.title!,
              ),
              RepoDetailItem(
                fieldName: "Date Time:",
                fieldValue: item.date!,
              ),
              RepoDetailItem(
                fieldName: "Location",
                fieldValue: item.location!,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppUIDimens.paddingMedium),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description :"),
                      Text("   ${item.description!}")
                    ],
                  ))
            ],
          ),
        ));
  }
}
