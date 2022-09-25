import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'jira_config.g.dart';

@JsonSerializable(explicitToJson: true)
class JiraConfig {
  static const jiraConfigPath = 'config/jira.json';
  late String userEmail;
  late String apiToken;
  late String subDomain;
  late String jql;

  static final JiraConfig _instance = JiraConfig._internal();

  factory JiraConfig() {
    return _instance;
  }

  JiraConfig._internal() {
    _setDefault();
  }

  Map<String, dynamic> toJson() => _$JiraConfigToJson(this);

  void setUserConfigFromString({String? email, String? token}) {
    if (email != null) {
      userEmail = email;
    }
    if (token != null) {
      apiToken = token;
    }
  }

  void setSubDomain(String value) {
    subDomain = value;
  }

  void setJql(String value) {
    jql = value;
  }

  Future<JiraConfig> load() async {
    final file = File(jiraConfigPath);
    if (!(await file.exists())) {
      return _instance;
    }

    final json = jsonDecode(await file.readAsString());
    userEmail = json['userEmail'] ?? '';
    apiToken = json['apiToken'] ?? '';
    subDomain = json['subDomain'] ?? '';
    jql = json['jql'] ?? '';

    return _instance;
  }

  Future<void> save() async {
    final file = File(jiraConfigPath);
    if (!(await file.exists())) {
      await file.create(recursive: true);
    }

    await file.writeAsString(jsonEncode(toJson()));
    return;
  }

  _setDefault() {
    userEmail = '';
    apiToken = '';
    subDomain = '';
    jql = '';
  }
}
