import 'package:json_annotation/json_annotation.dart';

part 'hardcoded_strings.g.dart';

@JsonSerializable()
class HardcodedStrings {
  final String matches;
  final String newGame;
  final String quickActions;
  final String lastTenMatches;
  final String statistics;
  final String history;
  final String leagues;
  final String pricing;
  final String settings;
  final String about;
  final String logout;
  // fixt below
  final String language;
  final String darkTheme;
  final String lightTheme;
  final String changePassword;
  final String enableNotifications;
  final String common;
  final String security;
  final String won;
  final String lost;
  final String scored;
  final String recieved;
  final String goals;
  final String user;
  final String username;
  final String organisation;
  final String personalInformation;
  final String integration;
  final String slack;
  final String discord;
  final String matchDetails;
  final String totalPlayingTime;
  final String newMatch;
  final String rematch;
  final String twoPlayers;
  final String fourPlayers;
  final String choosePlayers;
  final String match;
  final String startGame;
  final String chooseTeammate;
  final String chooseOpponent;
  final String chooseOpponents;
  final String matchReport;
  final String game;
  final String resume;
  final String pause;
  final String close;
  final String yes;
  final String no;
  final String cancel;
  final String areYouSureAlert;

  HardcodedStrings({
      required this.matches,
      required this.newGame,
      required this.quickActions,
      required this.lastTenMatches,
      required this.statistics,
      required this.history,
      required this.leagues,
      required this.pricing,
      required this.settings,
      required this.about,
      required this.logout,
      required this.language,
      required this.darkTheme,
      required this.lightTheme,
      required this.changePassword,
      required this.enableNotifications,
      required this.common,
      required this.security,
      required this.won,
      required this.lost,
      required this.scored,
      required this.recieved,
      required this.goals,
      required this.user,
      required this.username,
      required this.organisation,
      required this.personalInformation,
      required this.integration,
      required this.slack,
      required this.discord,
      required this.matchDetails,
      required this.totalPlayingTime,
      required this.newMatch,
      required this.rematch,
      required this.twoPlayers,
      required this.fourPlayers,
      required this.choosePlayers,
      required this.match,
      required this.startGame,
      required this.chooseTeammate,
      required this.chooseOpponent,
      required this.chooseOpponents,
      required this.matchReport,
      required this.game,
      required this.resume,
      required this.pause,
      required this.close,
      required this.yes,
      required this.no,
      required this.cancel,
      required this.areYouSureAlert
      });

  factory HardcodedStrings.fromJson(Map<String, dynamic> item) =>
      _$HardcodedStringsFromJson(item);

  Map<String, dynamic> toJson(item) => _$HardcodedStringsToJson(item);
}
