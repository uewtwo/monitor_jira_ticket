import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:monitor_jira_ticket/util/api.dart';
import '../model/config/jira_config.dart';
import '../repository/jira_repository.dart';
import '../response/result.dart';
import '../model/jira_search.dart';
import 'config/jira_config_provider.dart';

final jiraSearchRepository = FutureProvider<JiraSearchRepository>((_) async {
  final jiraConfig = await JiraConfig().load();

  final repository = JiraSearchRepository(
      dio: Dio(BaseOptions(baseUrl: getBaseApiUrl(jiraConfig.subDomain))));
  return repository;
});

// final jiraSearchProvider = FutureProvider<Result<JiraSearch>>((ref) async {
//   final jiraConfig = ref.read(jiraConfigProvider);
//   return ref
//       .watch(jiraSearchRepository)
//       .search(jiraConfig.value ?? JiraConfig());
// });
