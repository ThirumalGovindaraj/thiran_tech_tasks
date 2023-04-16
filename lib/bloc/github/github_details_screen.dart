import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasks/bloc/github/repo_detail_item.dart';

import 'github_response.dart';

class GithubDetailScreen extends StatelessWidget {
  final Items item;

  const GithubDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [Text("Repository Details")],
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
              ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                      imageUrl: item.owner!.avatarUrl!,
                      placeholder: (context, url) =>
                          const Icon(Icons.account_circle),
                      width: 50)),
              const SizedBox(
                height: 30,
              ),
              RepoDetailItem(
                fieldName: "Username",
                fieldValue: item.owner!.login!,
              ),
              RepoDetailItem(
                fieldName: "Repository Name",
                fieldValue: item.name!,
              ),
              RepoDetailItem(
                fieldName: "Repository Description",
                fieldValue: item.name!,
              ),
              RepoDetailItem(
                fieldName: "Numbers of stars for the repo",
                fieldValue: item.name!,
              ),
            ],
          ),
        ));
  }
}
