import 'package:json_annotation/json_annotation.dart';

part 'double_league_player_create.g.dart';

@JsonSerializable(explicitToJson: true)
class DoubleLeaguePlayerCreate {
  final int playerOneId;
  final int playerTwoId;
  final bool insertionSuccessfull;

  DoubleLeaguePlayerCreate({
    required this.playerOneId,
    required this.playerTwoId,
    required this.insertionSuccessfull,
  });

  factory DoubleLeaguePlayerCreate.fromJson(Map<String, dynamic> json) =>
      _$DoubleLeaguePlayerCreateFromJson(json);

  Map<String, dynamic> toJson() => _$DoubleLeaguePlayerCreateToJson(this);
}
