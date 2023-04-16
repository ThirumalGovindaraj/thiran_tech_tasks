import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasks/utilities/app_ui_dimens.dart';

import 'github_response.dart';

class GithubRepoItem extends StatelessWidget {
  final Items item;
  final GestureTapCallback? onTap;

  const GithubRepoItem({Key? key, required this.item, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          margin: const EdgeInsets.all(AppUIDimens.paddingXXSmall),
          child: Padding(
              padding: const EdgeInsets.all(AppUIDimens.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:CachedNetworkImage(
                      imageUrl: item.owner!.avatarUrl!,
                      placeholder: (context, url) =>
                          const Icon(Icons.account_circle_outlined),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.account_circle_outlined),
                      width: 50.0,
                    )),
                    const SizedBox(
                      width: AppUIDimens.paddingXLarge,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(item.name!), Text(item.fullName!)],
                    )
                  ])
                ],
              )),
        ));
  }
}
