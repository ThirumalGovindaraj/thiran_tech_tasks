import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:tasks/bloc/github/github_repo_item.dart';
import 'package:tasks/bloc/github/github_repository.dart';
import 'package:tasks/helpers/app_preferences.dart';
import 'package:tasks/utilities/common_utils.dart';

import 'github_response.dart';

class GithubListView extends StatefulWidget {
  const GithubListView({super.key});

  @override
  _GithubListViewState createState() => _GithubListViewState();
}

class _GithubListViewState extends State<GithubListView> {
  static const _pageSize = 30;

  final PagingController<int, Items> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    initSet();
    super.initState();
  }

  initSet() async {
    await AppPreferences.setNextPageUrl("");
    await AppPreferences.setLastPage(false);
    _fetchPage(_pageSize);
    _pagingController.addPageRequestListener((pageKey) async {
      if (!(AppPreferences.instance.isLastPage!)) {
        _fetchPage(pageKey);
      } else {
        debugPrint("Page loading completed");
      }
    });
  }

  final GithubRepository _repository = GithubRepository();

  Future<void> _fetchPage(int pageKey) async {
    // AppPreferences.instance.isLastPage
    try {
      final newItems =
          await _repository.getGithubRepository(url: CommonUtils.getUrl());
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey as int?);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text(
          "Github Repository List",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PagedListView<int, Items>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Items>(
            itemBuilder: (context, item, index) => GithubRepoItem(item: item),
            newPageProgressIndicatorBuilder: (context) {
              return AppPreferences.instance.isLastPage!
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Text("Page loading completed."),
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 30,top:10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Page loading .... "),
                            CircularProgressIndicator()
                          ],
                        ),
                      ));
            }),
      ));

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
