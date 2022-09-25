import 'package:json_annotation/json_annotation.dart';

import 'jira_issue_fields.dart';

part 'jira_issue.g.dart';

@JsonSerializable(explicitToJson: true)
class JiraIssue {
  String id;
  String key;
  JiraIssueFields fields;

  JiraIssue({required this.id, required this.key, required this.fields});

  factory JiraIssue.fromJson(Map<String, dynamic> json) =>
      _$JiraIssueFromJson(json);

  Map<String, dynamic> toJson() => _$JiraIssueToJson(this);
}
