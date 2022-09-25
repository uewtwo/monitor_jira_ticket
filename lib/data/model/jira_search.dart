import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../state/deploy_status.dart';
import 'jira_issue.dart';

part 'jira_search.g.dart';

@JsonSerializable(explicitToJson: true)
class JiraSearch {
  final String blockText = "devマージブロック（devマージは3つまで/そうではなくてもブロック中はマージ不可）";
  final String openText = "devマージ開放中（devマージは3つまで/そうではなくてもブロック中はマージ不可）";

  int startAt;
  int maxResults;
  int total;
  List<JiraIssue> issues;

  JiraSearch(
      {required this.startAt,
      required this.maxResults,
      required this.total,
      required this.issues});

  String getDeployStatus() {
    final summary = issues[0].fields.summary;
    if (summary == openText) {
      return DeployStatus.statusOpen;
    }
    if (summary == blockText) {
      return DeployStatus.statusBlock;
    }
    debugPrint('getDeployStatus error...');
    debugPrint('summary is $summary');
    return DeployStatus.statusError;
  }

  factory JiraSearch.fromJson(Map<String, dynamic> json) =>
      _$JiraSearchFromJson(json);

  Map<String, dynamic> toJson() => _$JiraSearchToJson(this);
}
