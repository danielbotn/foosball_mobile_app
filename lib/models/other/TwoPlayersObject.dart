import 'package:foosball_mobile_app/state/user_state.dart';

class TwoPlayersObject {
  UserState userState;
  String typeOfMatch;
  int matchId;
  int? leagueId;

  TwoPlayersObject({required this.userState, required this.typeOfMatch, required this.matchId, this.leagueId});
}