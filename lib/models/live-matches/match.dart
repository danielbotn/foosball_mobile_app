import 'package:dano_foosball/models/user/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'match.g.dart';

/// Define the enum with proper annotations for serialization
enum ETypeOfMatch {
  freehandMatch, // corresponds to 0
  doubleFreehandMatch, // corresponds to 1
  singleLeagueMatch, // corresponds to 2
  doubleLeagueMatch, // corresponds to 3
}

@JsonSerializable()
class Match {
  final ETypeOfMatch typeOfMatch; // Enum with custom JSON mapping
  final String typeOfMatchName;

  final int userId;
  final String userFirstName; // New field for User's first name
  final String userLastName; // New field for User's last name
  final String userPhotoUrl; // New field for User's photo URL

  final int? teamMateId; // Nullable field
  final String? teamMateFirstName; // Nullable field
  final String? teamMateLastName; // Nullable field
  final String? teamMatePhotoUrl; // Nullable field

  final int matchId;
  final int opponentId;
  final int? opponentTwoId; // Nullable field
  final String opponentOneFirstName;
  final String opponentOneLastName;
  final String opponentOnePhotoUrl;
  final String? opponentTwoFirstName; // Nullable field
  final String? opponentTwoLastName; // Nullable field
  final String? opponentTwoPhotoUrl; // Nullable field

  final int userScore;
  final int opponentUserOrTeamScore;
  final DateTime dateOfGame;
  final int? leagueId; // Nullable field

  final UserResponse? goalScorer; // Nullable field for goalScorer

  Match({
    required this.typeOfMatch,
    required this.typeOfMatchName,
    required this.userId,
    required this.userFirstName, // Initialize new field
    required this.userLastName, // Initialize new field
    required this.userPhotoUrl, // Initialize new field
    this.teamMateId, // Nullable field
    this.teamMateFirstName, // Nullable field
    this.teamMateLastName, // Nullable field
    this.teamMatePhotoUrl, // Nullable field
    required this.matchId,
    required this.opponentId,
    this.opponentTwoId, // Nullable field
    required this.opponentOneFirstName,
    required this.opponentOneLastName,
    required this.opponentOnePhotoUrl,
    this.opponentTwoFirstName, // Nullable field
    this.opponentTwoLastName, // Nullable field
    this.opponentTwoPhotoUrl, // Nullable field
    required this.userScore,
    required this.opponentUserOrTeamScore,
    required this.dateOfGame,
    this.leagueId,
    this.goalScorer, // Initialize goalScorer field
  });

  /// Factory method for converting JSON to a Match object
  factory Match.fromJson(Map<String, dynamic> json) {
    // Custom deserialization logic
    final typeOfMatch = _typeOfMatchFromJson(json['typeOfMatch'] as int);
    return Match(
      typeOfMatch: typeOfMatch,
      typeOfMatchName: json['typeOfMatchName'] as String,
      userId: json['userId'] as int,
      userFirstName: json['userFirstName'] as String, // Deserialize new field
      userLastName: json['userLastName'] as String, // Deserialize new field
      userPhotoUrl: json['userPhotoUrl'] as String, // Deserialize new field
      teamMateId: json['teamMateId'] as int?,
      teamMateFirstName: json['teamMateFirstName'] as String?,
      teamMateLastName: json['teamMateLastName'] as String?,
      teamMatePhotoUrl: json['teamMatePhotoUrl'] as String?,
      matchId: json['matchId'] as int,
      opponentId: json['opponentId'] as int,
      opponentTwoId: json['opponentTwoId'] as int?,
      opponentOneFirstName: json['opponentOneFirstName'] as String,
      opponentOneLastName: json['opponentOneLastName'] as String,
      opponentOnePhotoUrl: json['opponentOnePhotoUrl'] as String,
      opponentTwoFirstName: json['opponentTwoFirstName'] as String?,
      opponentTwoLastName: json['opponentTwoLastName'] as String?,
      opponentTwoPhotoUrl: json['opponentTwoPhotoUrl'] as String?,
      userScore: json['userScore'] as int,
      opponentUserOrTeamScore: json['opponentUserOrTeamScore'] as int,
      dateOfGame: DateTime.parse(json['dateOfGame'] as String),
      leagueId: json['leagueId'] as int?,
      goalScorer: json['goalScorer'] == null
          ? null
          : UserResponse.fromJson(json['goalScorer']), // Deserialize goalScorer
    );
  }

  /// Method for converting a Match object to JSON
  Map<String, dynamic> toJson() {
    return {
      'typeOfMatch': _typeOfMatchToJson(typeOfMatch),
      'typeOfMatchName': typeOfMatchName,
      'userId': userId,
      'userFirstName': userFirstName, // Serialize new field
      'userLastName': userLastName, // Serialize new field
      'userPhotoUrl': userPhotoUrl, // Serialize new field
      'teamMateId': teamMateId,
      'teamMateFirstName': teamMateFirstName,
      'teamMateLastName': teamMateLastName,
      'teamMatePhotoUrl': teamMatePhotoUrl,
      'matchId': matchId,
      'opponentId': opponentId,
      'opponentTwoId': opponentTwoId,
      'opponentOneFirstName': opponentOneFirstName,
      'opponentOneLastName': opponentOneLastName,
      'opponentOnePhotoUrl': opponentOnePhotoUrl,
      'opponentTwoFirstName': opponentTwoFirstName,
      'opponentTwoLastName': opponentTwoLastName,
      'opponentTwoPhotoUrl': opponentTwoPhotoUrl,
      'userScore': userScore,
      'opponentUserOrTeamScore': opponentUserOrTeamScore,
      'dateOfGame': dateOfGame.toIso8601String(),
      'leagueId': leagueId,
      'goalScorer': goalScorer?.toJson(), // Serialize goalScorer
    };
  }

  // Custom conversion for enum to and from JSON
  static ETypeOfMatch _typeOfMatchFromJson(int type) {
    switch (type) {
      case 0:
        return ETypeOfMatch.freehandMatch;
      case 1:
        return ETypeOfMatch.doubleFreehandMatch;
      case 2:
        return ETypeOfMatch.singleLeagueMatch;
      case 3:
        return ETypeOfMatch.doubleLeagueMatch;
      default:
        throw ArgumentError('Invalid match type: $type');
    }
  }

  static int _typeOfMatchToJson(ETypeOfMatch type) {
    switch (type) {
      case ETypeOfMatch.freehandMatch:
        return 0;
      case ETypeOfMatch.doubleFreehandMatch:
        return 1;
      case ETypeOfMatch.singleLeagueMatch:
        return 2;
      case ETypeOfMatch.doubleLeagueMatch:
        return 3;
    }
  }
}
