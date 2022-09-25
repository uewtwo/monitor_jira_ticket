import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:system_tray/system_tray.dart';

import '../data/model/config/jira_config.dart';
import '../data/repository/jira_repository.dart';
import '../data/state/deploy_status.dart';
import 'api.dart';
import 'image.dart';
import 'local_notification.dart';

Future<void> checkDeployStatus(
  SystemTray systemTray,
  DeployStatus deployStatus,
  FlutterLocalNotificationsPlugin plugin,
) async {
  const duration = Duration(seconds: 30);

  Timer.periodic(duration, (timer) async {
    final preDeployStatus = deployStatus.getStatus();
    final postDeployStatus = await fetchDeployStatus();
    systemTray.setSystemTrayInfo(
        iconPath: getTrayIconPathFromStatus(postDeployStatus));

    if (preDeployStatus != postDeployStatus) {
      deployStatus.changeDeployStatus(status: postDeployStatus);
    }

    if ((postDeployStatus == DeployStatus.statusOpen) &&
        (preDeployStatus != postDeployStatus)) {
      displayNotifications(plugin);
    }
  });
}

Future<String> fetchDeployStatus() async {
  final config = await JiraConfig().load();
  final jiraIssue = await JiraSearchRepository(
          dio: Dio(BaseOptions(baseUrl: getBaseApiUrl(config.subDomain))))
      .search(config);
  debugPrint('Merge Status Check Start...');
  final status = jiraIssue.when(
    success: (res) => res.getDeployStatus(),
    failure: ((err) {
      debugPrint(err.message);
      return DeployStatus.statusError;
    }),
    loading: () => DeployStatus.statusLoading,
  );
  debugPrint(config.toJson().toString());
  debugPrint(status);
  debugPrint('Merge Status Check End...');
  return status;
}
