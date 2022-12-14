import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'jira_config_provider.dart';

final jiraConfigEmailProvider = StateProvider.autoDispose((ref) {
  final readConfig = ref.watch(jiraConfigProvider);
  return TextEditingController(text: readConfig.value?.userEmail ?? '');
});
