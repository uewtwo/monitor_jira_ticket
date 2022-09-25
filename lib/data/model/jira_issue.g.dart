// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JiraIssue _$JiraIssueFromJson(Map<String, dynamic> json) => JiraIssue(
      id: json['id'] as String,
      key: json['key'] as String,
      fields: JiraIssueFields.fromJson(json['fields'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JiraIssueToJson(JiraIssue instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'fields': instance.fields.toJson(),
    };
