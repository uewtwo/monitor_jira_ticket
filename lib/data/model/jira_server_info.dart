// 認証疎通代わりに使用
import 'package:json_annotation/json_annotation.dart';

part 'jira_server_info.g.dart';

@JsonSerializable(explicitToJson: true)
class JiraServerInfo {
  String baseUrl;

  JiraServerInfo({required this.baseUrl});

  factory JiraServerInfo.fromJson(Map<String, dynamic> json) =>
      _$JiraServerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$JiraServerInfoToJson(this);
}
