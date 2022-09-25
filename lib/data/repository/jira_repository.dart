import 'dart:convert';

import 'package:dio/dio.dart';

import '../api/jira_api_client.dart';
import '../model/config/jira_config.dart';
import '../model/jira_search.dart';
import '../model/jira_server_info.dart';
import '../response/result.dart';

class JiraSearchRepository {
  final JiraApiClient _client;
// ここを使う側で、baseUrlが更新されていたらclientを渡すようにしたら良さそう
  JiraSearchRepository({Dio? dio})
      : _client = dio != null ? JiraApiClient(dio) : JiraApiClient(Dio());

  Future<Result<JiraSearch>> search(JiraConfig config) async {
    final jql = config.jql;
    final username = config.userEmail;
    final apiToken = config.apiToken;

    final auth = _getBasicAuth(username, apiToken);

    try {
      final res = await _client.searchFromJql(auth, jql);
      return Result.success(res);
    } on DioError catch (err) {
      return Result.failure(err);
    }
  }

  Future<Result<JiraServerInfo>> serverInfo(JiraConfig config) async {
    final username = config.userEmail;
    final apiToken = config.apiToken;

    final auth = _getBasicAuth(username, apiToken);
    try {
      final res = await _client.serverInfo(auth);
      return Result.success(res);
    } on DioError catch (err) {
      return Result.failure(err);
    }
  }

  String _getBasicAuth(String username, String apiToken) =>
      "Basic ${base64.encode(utf8.encode('$username:$apiToken'))}";
}
