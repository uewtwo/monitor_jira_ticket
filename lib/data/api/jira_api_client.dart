import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../model/jira_myself.dart';
import '../model/jira_search.dart';

part 'jira_api_client.g.dart';

@RestApi()
abstract class JiraApiClient {
  factory JiraApiClient(Dio dio) = _JiraApiClient;

  @GET("/search")
  Future<JiraSearch> searchFromJql(
    @Header("authorization") String auth,
    @Query("jql") String jql,
  );

  @GET("/myself")
  Future<JiraMyself> myself(
    @Header("authorization") String auth,
  );
}
