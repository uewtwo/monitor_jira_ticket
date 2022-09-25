// 認証疎通代わりに使用
import 'package:json_annotation/json_annotation.dart';

part 'jira_myself.g.dart';

@JsonSerializable(explicitToJson: true)
class JiraMyself {
  String self;

  JiraMyself({required this.self});

  factory JiraMyself.fromJson(Map<String, dynamic> json) =>
      _$JiraMyselfFromJson(json);

  Map<String, dynamic> toJson() => _$JiraMyselfToJson(this);
}
