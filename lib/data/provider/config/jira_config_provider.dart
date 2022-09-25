import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../model/config/jira_config.dart';

final jiraConfigProvider =
    FutureProvider<JiraConfig>((_) async => await JiraConfig().load());
