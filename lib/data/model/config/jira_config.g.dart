// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jira_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JiraConfig _$JiraConfigFromJson(Map<String, dynamic> json) => JiraConfig()
  ..userEmail = json['userEmail'] as String
  ..apiToken = json['apiToken'] as String
  ..subDomain = json['subDomain'] as String
  ..jql = json['jql'] as String;

Map<String, dynamic> _$JiraConfigToJson(JiraConfig instance) =>
    <String, dynamic>{
      'userEmail': instance.userEmail,
      'apiToken': instance.apiToken,
      'subDomain': instance.subDomain,
      'jql': instance.jql,
    };
