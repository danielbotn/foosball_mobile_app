import 'package:json_annotation/json_annotation.dart';

part 'team-member-model.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamMemberModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  TeamMemberModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory TeamMemberModel.fromJson(Map<String, dynamic> json) =>
      _$TeamMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamMemberModelToJson(this);
}
