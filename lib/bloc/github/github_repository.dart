import 'dart:convert';

import 'package:tasks/bloc/github/github_response.dart';
import 'package:http/http.dart' as http;
import 'package:tasks/utilities/validation_utils.dart';
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
    dynamic response = await _helper.get(url);
    if (response is! ErrorResponse) {
      return GithubResponse.fromJson(response);
    } else {
      return response;
    }
  }
}
