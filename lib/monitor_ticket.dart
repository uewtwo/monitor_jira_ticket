import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/provider/config/jira_config_api_token_provider.dart';
import 'data/provider/config/jira_config_email_provider.dart';
import 'data/provider/config/jira_config_jql_provider.dart';
import 'data/provider/config/jira_config_provider.dart';
import 'data/provider/config/jira_config_sub_domain_provider.dart';
import 'ui/page/system_tray/system_tray.dart';

class MonitorTicket extends HookConsumerWidget {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  MonitorTicket({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subDomainController = ref.watch(jiraConfigSubDomainProvider);
    final jqlController = ref.watch(jiraConfigJqlProvider);
    final emailController = ref.watch(jiraConfigEmailProvider);
    final apiTokenController = ref.watch(jiraConfigApiTokenProvider);
    final jiraConfig = ref.watch(jiraConfigProvider);

    return StatefulSystemtray(
      subDomainController: subDomainController,
      jqlController: jqlController,
      emailController: emailController,
      apiTokenController: apiTokenController,
      notificationPlugin: _notificationsPlugin,
      jiraConfig: jiraConfig,
    );
  }
}
