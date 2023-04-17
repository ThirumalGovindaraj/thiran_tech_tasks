import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/github/github_repo_item.dart';
import 'package:tasks/utilities/app_ui_dimens.dart';
import 'package:tasks/utilities/common_utils.dart';

import 'github_bloc.dart';
import 'package:intl/intl.dart';

class GithubScreen extends StatefulWidget {
  const GithubScreen({Key? key}) : super(key: key);

  @override
  State<GithubScreen> createState() => _GithubScreenState();
}

class _GithubScreenState extends State<GithubScreen> {
  @override
  void initState() {
    context.read<GithubBloc>().add(PageOnLoadEvent(
        "https://api.github.com/search/repositories?q=created:%3E${getDate()}&sort=stars&order=desc"));
    super.initState();
  }

  getDate() {
    return DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(const Duration(days: 30)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Github Repository",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: BlocBuilder<GithubBloc, GithubState>(
          builder: (context, state) {
            if (state is GithubLoaded) {
              return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppUIDimens.paddingXXSmall),
                  itemBuilder: (context, index) {
                    return GithubRepoItem(
                      item: state.response.items![index],
                      onTap: () {
                        CommonUtils.showBottomSheet(context,
                            repoItem: state.response.items![index]);
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Container(),
                  itemCount: state.response.items!.length);
            } else if (state is GithubError) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.error.message!,
                            style: Theme.of(context).textTheme.headline1)
                      ]));
            } else if (state is GithubLoading) {
              return CommonUtils.loadingWidget();
            } else {
              return CommonUtils.loadingWidget();
            }
          },
        ),
      ),
    );
  }
}
