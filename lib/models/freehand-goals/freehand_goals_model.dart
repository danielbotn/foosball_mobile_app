import 'package:json_annotation/json_annotation.dart';

part 'freehand_goals_model.g.dart';

@JsonSerializable()
class FreehandGoalsModel {
  final int id;
  final DateTime timeOfGoal;
  final int matchId;
  final int scoredByUserId;
  final String scoredByUserFirstName;
  final String scoredByUserLastName;
  final String scoredByUserPhotoUrl;
  final int oponentId;
  final String oponentFirstName;
  final String oponentLastName;
  final String oponentPhotoUrl;
  final int scoredByScore;
  final int oponentScore;
  final bool winnerGoal;
  

  FreehandGoalsModel(
      {required this.id,
      required this.timeOfGoal,
      required this.matchId,
      required this.scoredByUserId,
      required this.scoredByUserFirstName,
      required this.scoredByUserLastName,
      required this.scoredByUserPhotoUrl,
      required this.oponentId,
      required this.oponentFirstName,
      required this.oponentLastName,
      required this.oponentPhotoUrl,
      required this.scoredByScore,
      required this.oponentScore,
      required this.winnerGoal,
      });

  factory FreehandGoalsModel.fromJson(Map<String, dynamic> item) =>
      _$FreehandGoalsModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$FreehandGoalsModelToJson(item);
}
