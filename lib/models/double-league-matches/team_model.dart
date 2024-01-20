import 'package:json_annotation/json_annotation.dart';

part 'team_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TeamModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String photoUrl;
  final String teamName;
  final int userId;
  final int teamId;

  TeamModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.photoUrl,
      required this.teamName,
      required this.userId,
      required this.teamId});

  factory TeamModel.fromJson(Map<String, dynamic> json) =>
      _$TeamModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeamModelToJson(this);
}
