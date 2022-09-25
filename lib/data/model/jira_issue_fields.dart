import 'package:json_annotation/json_annotation.dart';

part 'jira_issue_fields.g.dart';

@JsonSerializable(explicitToJson: true)
class JiraIssueFields {
  String summary;

  JiraIssueFields({required this.summary});

  factory JiraIssueFields.fromJson(Map<String, dynamic> json) =>
      _$JiraIssueFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$JiraIssueFieldsToJson(this);
}
