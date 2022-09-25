// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JiraSearch _$JiraSearchFromJson(Map<String, dynamic> json) => JiraSearch(
      startAt: json['startAt'] as int,
      maxResults: json['maxResults'] as int,
      total: json['total'] as int,
      issues: (json['issues'] as List<dynamic>)
          .map((e) => JiraIssue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JiraSearchToJson(JiraSearch instance) =>
    <String, dynamic>{
      'startAt': instance.startAt,
      'maxResults': instance.maxResults,
      'total': instance.total,
      'issues': instance.issues.map((e) => e.toJson()).toList(),
    };
