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

  HardcodedStrings(
    {
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
    }
  );

   factory HardcodedStrings.fromJson(Map<String, dynamic> item) =>
      _$HardcodedStringsFromJson(item);

  Map<String, dynamic> toJson(item) => _$HardcodedStringsToJson(item);
}