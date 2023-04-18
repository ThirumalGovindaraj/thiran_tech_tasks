import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasks/bloc/github/github_response.dart';
import 'package:tasks/utilities/common_utils.dart';

import '../../helpers/app_preferences.dart';
import '../../helpers/webservice_helper.dart';
import 'error_response.dart';

abstract class GithubRepositoryInterface {
  Future<dynamic> getGithubRepository({required String url});
}

class GithubRepository implements GithubRepositoryInterface {
  final WebServiceHelper _helper = WebServiceHelper();

  GithubRepository();

  @override
  Future getGithubRepository({required String url}) async {
    http.Response response = await _helper.get(url);
    if (response is! ErrorResponse) {
      Map<String, String> url =
          CommonUtils.parseLinkHeader(response.headers["link"]!);
      if (url.containsKey("next")) {
        await AppPreferences.setLastPage(false);
        await AppPreferences.setNextPageUrl(url["next"]!);
      } else {
        await AppPreferences.setLastPage(true);
      }

      return GithubResponse.fromJson(jsonDecode(response.body)).items;
    } else {
      return response;
    }
  }
}
